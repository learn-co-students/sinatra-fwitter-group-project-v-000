class UserController < ApplicationController

  get '/signup' do
    if @user = User.find_by_id(session[:user_id])
      redirect :'/tweets'
    else
      erb :"/users/create_user"
    end
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email] ,:password => params[:password])
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
      @user.save
      session[:user_id] = @user.id
      redirect :"/tweets"
    else
      redirect :"/signup"
    end
  end

  get '/login' do
    if logged_in?
      redirect :"/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
    end
    redirect :'/tweets'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect :"/login"
    else
      redirect :"/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

end
