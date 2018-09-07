class UsersController < ApplicationController

  get "/signup" do
    if !logged_in?
      erb :'/users/create_user'
    else
     redirect '/tweets'
    end
  end

  post "/signup" do
    if params[:username] =="" || params[:email] =="" || params[:password] == ""
      redirect '/signup'
    elsif logged_in?
      redirect to '/tweets'
    else
      @user = User.create(params[:user])
      session[:user_id] = @user 
      redirect to '/tweets'
    end
  end

  get "/login" do
    if !logged_in?
      erb :'/users/login'
    else
     redirect to '/tweets'
    end
  end

  # post "/login" do
  #   @user = User.find_by(username: params[:username])
  #   if @user && @user.authenticate(params[:password])
  #     session[:user_id] = @user.id
  #     redirect to "/tweets"
  #   else
  #     redirect to "/signup"
  #   end
  # end
  
  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

  
end
