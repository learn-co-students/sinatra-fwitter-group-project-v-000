require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    @session = session
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/signup' do
    if session[:user_id] != nil
      redirect '/tweets/tweets'
    elsif params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect '/signup'
    else
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end


  post '/login' do
    user = User.find_by(username: params[:username])
    if user
      if user.authenticate(params[:password]) && user.id != session[:user_id]
        session[:user_id] = user.id
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect "/login"
    end
  end
  #
  # post '/tweets' do
  #   # current_user
  # end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
    erb :'/tweets/create_tweet'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect "/login"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_id(session[:user_id])
    erb :'/users/show'
  end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end


end
