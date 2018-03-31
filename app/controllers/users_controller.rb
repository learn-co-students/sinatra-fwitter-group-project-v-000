class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["password"].empty? && !params["email"].empty?
      @user = User.create(username: params["username"], password: params["password"], email: params["email"])
      session[:user_id] = @user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    if User.find_by(username: params[:username], password: params[:password])
      @user = User.find_by(username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      redirect to '/'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end
end
