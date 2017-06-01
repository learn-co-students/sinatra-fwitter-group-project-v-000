class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    @user = User.new(params)

    if @user.save
      @user.save
      session[:id] = @user.id
      flash[:notice] = "Successfully created new user."
      redirect '/tweets'
    else
      flash[:error] = "You need to complete all required fields"
      redirect '/signup'
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
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      flash[:notice] = "Welcome, #{@user.username}."
      session[:id] = @user.id
      redirect '/tweets'
    else
      flash[:error] = "Incorrect username and/or password."
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:notice] = "You have logged out."
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/users/show'
  end
end
