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

  get '/twitter' do
    erb :'/tweets/tweets'
  end

  get '/signup' do
    erb :create_user
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    end
    session[:id] = @user.id
# this, session[:id] = @user.id, logs the user in
    redirect '/twitter/tweets'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    # okay this isn't working, @user.id is throwing error of nil class
     @user = User.find_by(username: params[:username], password: params[:password])
# I don't think it's working in shotgun because I'm not entering input that is in db
     session[:id] = @user.id
    erb :'/tweets/tweets'
  end





end
