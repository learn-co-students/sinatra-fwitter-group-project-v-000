class UsersController < ApplicationController

  get "/users" do

  end

  post "/users/login" do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  post "/users/signup" do
    username = params[:username].gsub(" ", "")
    email = params[:email].gsub(" ", "")
    password = params[:password].gsub(" ", "")

    if username.empty? || email.empty? || password.empty?
      redirect "/signup"
    else
      User.create(params)

      redirect "/login"
    end
  end



  get "/users/:id" do
    erb :"/users/show_user"
  end

  get "/users/:id/edit" do
    erb :"/users/edit_user"
  end

  patch "/users/:id" do

  end

  delete "/users/:id" do

  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
