require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if params[:user].values.any? {|a| a == [] || a == "" || a == nil}
      flash[:message] = "Your username/password/email is invalid. Please try again."
      redirect "/signup"
    else
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    if session[:user_id] != nil && session[:user_id] != ""
      user = User.find_by(username: params[:user][:username])
      if user && user.authenticate(params[:user][:password])
          session[:user_id] = user.id
          "Welcome, #{user.username}!"
          redirect "/tweets"
      else
        flash[:message] = "Your username/password is invalid. Please try again."
        redirect "/login"
      end
    else
      redirect "/tweets"
    end
  end

  get '/logout' do
    if session[:user_id] != nil && session[:user_id] != ""
      session.clear
      flash[:message] = "You are logged out."
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :user_show
  end

  get '/tweets' do
    if User.find_by(id: session[:user_id])
      erb :show
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if User.find_by(id: session[:user_id])
      erb :new
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    if params[:tweet][:content] != ""
      user = User.find_by(id: session[:user_id])
      tweet = Tweet.create(params[:tweet])
      tweet.user_id = user.id
      tweet.save
      user.tweets << tweet
      user.save
      redirect "/tweets"
    else
      redirect "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if User.find_by(id: session[:user_id])
      @tweet = Tweet.find_by(id: params[:id])
      erb :tweet_show
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if User.find_by(id: session[:user_id]) == @tweet.user
      erb :edit
    elsif session[:id] != nil && session[:id] != ""
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if params[:tweet][:content] != ""
      @tweet.update(params[:tweet])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  get '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    if User.find_by(id: session[:user_id]) == @tweet.user
      erb :delete
    elsif session[:user_id] != nil
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.delete
    redirect "/tweets"
  end

end
