require 'pry'
class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  get '/logout' do
    logout
    redirect '/login'
  end

  get '/users/:id' do
    @user = User.find_by_slug(params["id"])
    erb :'/users/show'
  end

  post '/signup' do
    if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect  '/tweets'
    else
      redirect '/signup'
    end
  end


  post '/login' do
    @user = User.find_by(username: params["username"])

    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end


end
