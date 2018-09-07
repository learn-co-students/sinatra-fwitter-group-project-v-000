class UsersController < ApplicationController

  get "/signup" do
    erb :'users/create_user'
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      redirect to '/users/create_user'
    else
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] << @user 
      redirect to '/index'
    end

  end

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/users/show"
    else
      redirect to "/users/login"
    end
  end
  
  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    
    def logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find(session[:user_id])
    end
  end
end
