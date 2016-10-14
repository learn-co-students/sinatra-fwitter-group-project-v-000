class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/new'
    else
      redirect '/tweets'
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
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  post '/signup' do
    if User.create(params).valid?
      session[:user_id] = User.find_by(:username => params[:username]).id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

end
