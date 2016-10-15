class UsersController < ApplicationController
  get '/signup' do
    if session[:id].nil?
      erb :'users/signup'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if (params[:username].empty? || params[:password].empty? || params[:email].empty?)
      redirect '/signup'
    else
      user = User.create(params)
      session[:id] = user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !session[:id].nil?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    session[:id] = user.id
    if user.authenticate(params[:password])
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
    erb :'users/index'
  end

end
