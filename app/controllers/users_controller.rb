class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/tweets'
    end
    erb :'users/signup'
  end

  post '/signup' do
    if params[:username] == ""
      redirect '/signup'
    elsif params[:email] == ""
      redirect '/signup'
    elsif params[:password] == ""
      redirect '/signup'
    else
      user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
      if user.save
        session[:user_id] = user.id
        redirect '/tweets'
      else
        redirect '/signup'
      end
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    if params[:username] == ""
      redirect '/login'
    elsif params[:password] == ""
      redirect '/login'
    else
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweet.find_by(user_id: @user.id)
    erb :'users/show'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
