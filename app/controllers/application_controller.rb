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

  #helper methods:
  # logged-in?
  # current user

  get '/twitter' do
    erb :'/tweets/tweets'
  end

  get '/signup' do
    erb :create_user
  end

  post '/signup' do
# Need to put a condition in here that checks to see if info belongs to user
# if so redirect to tweets?
    
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    end
    session[:user_id] = @user.id
# this, session[:id] = @user.id, logs the user in
    redirect '/twitter/tweets'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
     @user = User.find_by(username: params[:username])
     if @user != nil && @user.password == params[:password]
       session[:user_id] = @user.id
       #binding.pry
       erb :'/tweets/index'
     else
       redirect '/login'
     end
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
