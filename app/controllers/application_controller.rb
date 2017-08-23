require 'pry'
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

  get '/signup' do
    if logged_in?
      @user = current_user
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post "/signup" do
    if User.find_by(username: params[:username]) != nil
      @user = User.find_by(username: params[:username])
      session[:id] = @user.id
      redirect "/tweets"
    elsif logged_in?
      @user = current_user
      redirect "/tweets"
    elsif params[:username] != "" && params[:email] != "" && params[:password] != "" && !logged_in?
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if logged_in?
      @user = current_user
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      @user = User.find_by(:username => params[:username])
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/failure"
    end
  end

  get "/success" do
    if logged_in?
      erb :success
    else
      redirect "/login"
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end
end
