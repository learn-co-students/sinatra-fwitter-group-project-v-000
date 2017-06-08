require 'pry'
class UserController < ApplicationController

  get '/signup' do
    if session[:id] == nil
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end

  get '/users/login' do
    erb :'users/login'
  end

  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end
  get '/fail' do
    erb :fail
  end
  post '/signup' do
    if params["username"] == "" || params["email"] == "" || params["password"] == ""
      redirect '/signup'
    else
        @user = User.create(username: params["user_name"], email: params["email"], password: params["password"])
        session[:id] = @user.id
        redirect '/tweets'
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end
