class UserController < ApplicationController
  get '/' do
    erb :'users/index'
  end

  get '/signup' do
    redirect '/tweets' if session.key?(:user_id)
    erb :'users/new'
  end

  post '/signup' do
    redirect '/signup' if params[:username].empty?
    redirect '/signup' if params[:email].empty?
    redirect '/signup' if params[:password].empty?

    user = User.create(username: params[:username],
                       email: params[:email],
                       password: params[:password])
    session[:user_id] = user.id
    redirect '/tweets'
  end

  get '/login' do
    redirect '/tweets' if session.key?(:user_id)
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end
end
