class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      log_in_user
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = Tweet.all { |tweet| tweet.user_id == @user.id }
    erb :'users/show'
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    end
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      log_in_user
      redirect '/tweets'
    else
      redirect '/users/failure'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    end
    redirect '/'
  end
end
