require './config/environment'
require 'pry'

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
  
  get '/signup' do
    if !logged_in?
      erb :signup
    else 
      redirect "/tweets"
    end 
  end 
  
  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else  
      user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end 
  
  get '/login' do
    if logged_in?
      redirect '/tweets/index'
    else
    erb :'users/login'
    end 
  end 
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets" 
    else
      erb :'users/login'
    end 
  end 
  
  get '/logout' do
    if !logged_in?
    redirect "/login"
  else 
    session.clear
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
  