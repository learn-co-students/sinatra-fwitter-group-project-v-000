class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/signup'
    end
  end

  post '/signup' do
    if !params[:username].empty? and !params[:email].empty? and !params[:password].empty?
      user = User.create(params)
      session[:user_id] = user.id
    else
      redirect '/signup'
    end
    redirect '/tweets'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :user
  end

end
