require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
      erb :index
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
      #binding.pry ~ It's showing a user logged in.  This shouldn't be.
      @user = User.find_by(session[:user_id])
      # However, it does make it to the erb :tweets page!
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    end
    session[:user_id] = @user.id
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
     @user = User.find_by(username: params[:username])
     if @user != nil && @user.password == params[:password]
       session[:user_id] = @user.id
       redirect '/tweets'
     else
       redirect '/login'
     end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweet.all
    erb :'/users/show'
  end

  get '/tweets/:slug' do
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
