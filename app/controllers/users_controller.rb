class UsersController < ApplicationController

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :show
  end

  get '/signup' do
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      flash[:message] = "Please log out of your account first to sign up another account"
      redirect "/tweets"
    else
      erb :signup
    end
  end

  post '/signup' do
    if params[:username].empty?
      flash[:message] = "Please enter a valid username."
      redirect "/signup"
    elsif params[:email].empty?
      flash[:message] = "Please enter a valid email."
      redirect "/signup"
    elsif params[:password].empty?
      flash[:message] = "Please enter a valid password."
      redirect "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      flash[:message] = "Already logged in."
      redirect "/tweets"
    else
      erb :login
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      flash[:message] = "Incorrect username/password."
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect to '/'
    end
  end

end
