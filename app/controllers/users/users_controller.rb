class UsersController < ApplicationController
  get "/" do
    erb :"user/home"
  end

  get "/signup" do
    if !logged_in?
      erb :"/user/signup"
    else
      redirect "/tweets"
    end
  end

  post "/signup" do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user = User.create(params)
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if !logged_in?
      erb :"/user/login"
    else
      redirect "/tweets"
    end
  end

  post "/login" do
    if !params[:username].empty? && !params[:password].empty?
      @user = User.find_by(username: params[:username], password: params[:password])
      session[:id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end
end
