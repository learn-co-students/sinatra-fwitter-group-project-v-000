class UsersController < ApplicationController

  get "/signup" do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :"/users/create_user"
    end
  end

  post "/signup" do
    if params.values.any? &:empty?
      redirect '/signup'
    end
    user = User.create(:username => params[:username], :password_digest => params[:password], :email => params[:email])
    session[:user_id] = user.id
    redirect '/tweets'
  end

  get "/login" do
    if logged_in?
      redirect '/tweets'
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    end
    if logged_in?
      redirect '/tweets'
    else
      redirect '/login' 
    end
  end
  
  get "/users/:slug" do 
      @user = User.find_by_slug(params[:slug])
      erb :"/users/show"
  end
  
  get "/logout" do
    logged_in?
    session.destroy
    redirect "/login"
  end

end