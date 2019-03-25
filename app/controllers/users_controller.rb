class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if User.find_by(:username => params[:username]) || User.find_by(:email => params[:email])
      redirect '/login'
    elsif !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/users/:slug'do
    @user = User.all.find_by_slug(params[:slug])
    @user_tweets = @user.tweets
    erb :'users/show'
  end


  get '/logout' do
    logout! if logged_in?
    redirect '/login'
  end
end
