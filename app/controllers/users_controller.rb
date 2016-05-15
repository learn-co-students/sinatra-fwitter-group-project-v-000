require 'sinatra/base'
require 'rack-flash'
class UsersController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/signup' do
    if !session[:user_id]
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    username = params["username"].size
    email = params["email"].size
    password = params["password"].size

    if username < 1 || email < 1 || password < 1
      flash[:message] = "Inputs may not be blank."
      redirect to "/signup"
    else
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      flash[:message] = "You have successfully signed up."
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "You have signed in successfully."
      redirect to '/tweets'
    else
      flash[:message] = "Invalid username or password. Please try again."
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
end
