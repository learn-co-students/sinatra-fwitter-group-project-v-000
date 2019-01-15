class UsersController < ApplicationController

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])

    erb :"/users/show"
  end

  get "/login" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/signup" do
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/create_user"
    end
  end

  post "/signup" do
    username = params[:username].gsub(" ", "")
    email = params[:email].gsub(" ", "")
    password = params[:password].gsub(" ", "")

    if username.empty? || email.empty? || password.empty?
      redirect "/signup"
    else
      user = User.create(params)

      session[:user_id] = user.id

      redirect "/tweets"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
    end

    redirect "/login"
  end
end
