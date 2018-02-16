
require 'pry'
class UserController < ApplicationController



  get '/login' do
     if logged_in?
       redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"], password: params["password"])

    if @user
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

  get '/signup' do

    if logged_in?
      redirect to'/tweets/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(username: params["username"], password: params["password"], email: params["email"] )
    @user.save
    if @user.username != "" && @user.password != "" && @user.email != ""
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do

    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end

  end

  get '/users/:slug' do
     @user = User.find_by(slug: params[:slug])
     erb :'/users/show'
  end
end
