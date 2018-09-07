class UsersController < ApplicationController

  get "/signup" do
    erb :'users/create_user'
  end

  post "/signup" do
    if params[:username] =="" || params[:email] =="" || params[:password] == ""
      redirect '/signup'
    elsif logged_in?
      redirect to '/tweets'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user 
      redirect to '/tweets'
    end
  end

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end
  
  get "/logout" do
    session.clear
    redirect "/login"
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
