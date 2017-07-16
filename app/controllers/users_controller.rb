class UsersController < ApplicationController

  get '/' do
    erb :index
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      flash[:message] = "You are already logged in. Redirecting to your tweets."
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Not all required fields were given. Please try again."
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      flash[:message] = "Thanks for signing up for Fwitter!"
      redirect to '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      flash[:message] = "You are already logged in. Redirecting to your tweets."
      redirect to '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if params[:username] == "" || params[:password] == ""
      flash[:message] = "Either the username and/or the password wasn't provided. Please try again."
      redirect to '/login'
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome, #{@user.username}."
      redirect to '/tweets'
    else
      flash[:message] = "Log in failed. Please try again."
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/login'
    end
  end

end