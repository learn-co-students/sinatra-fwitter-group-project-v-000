class UsersController < ApplicationController

  get "/signup" do
    login_status_display
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/signup"
    end
  end

  post "/signup" do
    login_status_display
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.save
    if @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    login_status_display
    if logged_in?
      redirect "/tweets"
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    login_status_display
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    login_status_display
    session.clear
    redirect "/login"
  end


  get "/users/:slug" do
    @tweets = Tweet.all
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

end
