require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

#signup

  get '/signup' do
    if logged_in?
      redirect to "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    if params["username"] != "" && params["email"] != "" && params["password"] != ""
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

#login && logout

  get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect to "/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    if @user && @user.authenticate(params["password"])
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
      redirect to "/login"
  end

#tweets

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :"tweets/tweets"
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if !(params["content"].empty?) && logged_in?
      tweet = Tweet.create(content: params["content"])
      @user = current_user
      @user.tweets << tweet
    else
      redirect to "/tweets/new"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show_tweet"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  patch '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && @tweet.user_id == current_user.id
      @tweet.delete
    end
      redirect to '/tweets'
  end

  #users

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"tweets/show_tweet"
  end

#helpers

  helpers do
    def current_user
      User.find(session[:id])
    end

    def logged_in?
      !!(session[:id])
    end
  end

end
