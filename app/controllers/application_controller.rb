require './config/environment'
require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
      enable :sessions
      set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :signup
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/signup' do
    if !params['username'].empty? && !params['email'].empty? && !params['password'].empty?
      @user = User.create(username: params['username'], email: params['email'], password: params['password'])
      @user.save
      session[:id] = @user.id # @user is now logged in
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id # @user is now logged in
      redirect '/tweets'
    else
      erb :login
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = Helpers.current_user(session)
    if !params["content"].empty?
      @tweet = @user.tweets.create(content: params["content"])
    else
      redirect '/tweets/new'
    end
    redirect '/tweets'
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id=params[:id])
    if Helpers.is_logged_in?(session)
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @user = Helpers.current_user(session)
    @tweet = Tweet.find_by(id=params[:id])
    if Helpers.is_logged_in?(session) && @tweet.user_id == @user.id
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.update(content: params[:content])
    @tweet.save
  end

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      erb :tweets
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear # @user is now logged out
    end
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.delete if @tweet.user == Helpers.current_user(session)
    redirect '/tweets'
  end

end
