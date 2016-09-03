class UsersController < ApplicationController

  get "/signup" do
    if !logged_in?
      erb :signup
    else
      redirect to "/tweets"
    end
  end

  get "/login" do
    if !logged_in?
      erb :login
    else
      redirect to "/tweets"
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "All fields are required."
      redirect to "/signup"
    else
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if user.save
        session[:id] = user.id
        redirect to "/tweets"
      else
        flash[:message] = "Something went wrong. Please try again."
        redirect to "/signup"
      end
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      flash[:message] = "Wrong username or password. Please try again."
      redirect to "/login"
    end
  end

  get "/logout" do
    if logged_in?
      @title = "Fwitter"
      session.destroy
      flash[:message] = "You have been logged out."
      redirect to "/login"
    else
      redirect to "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/show'
  end
end
