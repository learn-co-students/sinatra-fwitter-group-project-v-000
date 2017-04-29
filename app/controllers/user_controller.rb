class UserController < ApplicationController

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"views/users/user_tweets"
  end

  get "/signup" do
    if logged_in?
      redirect to '/tweets'
    else
      erb :"views/users/create_user"
    end
  end

  post "/signup" do
    if !params[:username].blank? && !params[:email].blank? && !params[:password].blank?
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get "/login" do
    if logged_in?
     redirect to "/tweets"
    else
      erb :'views/users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      @user = user
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end


end
