require './config/environment'

class UserController < ApplicationController

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
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "login"
    else
      redirect "/"
    end
  end

end
