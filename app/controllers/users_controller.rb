class UsersController < ApplicationController

  get "/signup" do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect "/tweets"
    end
  end

  post "/signup" do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if !logged_in?
      erb :"users/login"
    else
      redirect "/tweets"
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/logout" do
    if !logged_in?
      redirect "/"
    else
      session.clear
      redirect "/login"
    end
  end

  get "/users/:slug" do
    @tweets = current_user.tweets
    erb :"users/show"
  end

end
