require './config/environment'
require 'bcrypt'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'password_security'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if session[:id]
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      user.save
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if session[:id]
      redirect '/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if logged_in?
      redirect '/tweets'
    elsif user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    if session[:id]
      @user = User.find(session[:id])
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      Tweet.create(content: params[:content], user_id: session[:id]) unless params[:content] == ""
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet'
    end
  end

  patch '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user.id == session[:id]
        @tweet.content = params[:content] unless params[:content] == ""
        @tweet.save
      end
      erb :'/tweets/show_tweet'
    end
  end

  delete '/tweets/:id/delete' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find(params[:id])
      if @tweet.user.id == session[:id]
        Tweet.destroy(params[:id])
      end
      redirect '/tweets'
    end
  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    else
      session.clear
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/tweets'
  end


  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end

    def current_user_tweets
      current_user.tweets
    end
  end

end
