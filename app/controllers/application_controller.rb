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
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:id] = user.id
    erb :'/tweets/tweets'
  end

  get '/login' do
    if session[:id]
      redirect '/tweets'
    end
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if user && user.authenticate(password: params[:password])
      session[:id] = @user.id
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
