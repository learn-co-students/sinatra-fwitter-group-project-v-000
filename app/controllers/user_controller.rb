require './config/environment'

class UserController < ApplicationController

  get "/signup" do
    session[:user_id] ? (redirect to "/tweets") : (erb :'/users/signup')
  end

  post "/signup" do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect to "/signup"
    end
  end

  get "/login" do
    session[:user_id] ? (redirect to "/tweets") : (erb :'/users/login')
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect to "/login"
    else
      redirect to "/"
    end
  end


end
