class UserController < ApplicationController
  
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_users'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:message] = "Fields cannot be empty, please try again."
      redirect '/signup'
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:id] = user.id
      flash[:message] = "Tweet successfully created."
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/tweets'
    else
      flash[:message] = "User or password not found."
      redirect '/login'
    end

  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    if @user = User.find_by_slug(params[:slug])
      erb :"/tweets/tweets"
    else
      redirect '/'
    end
  end
end