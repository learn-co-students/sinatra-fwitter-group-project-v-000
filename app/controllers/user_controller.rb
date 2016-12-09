require './config/environment'

class UserController < ApplicationController
  
  get '/signup/?' do
    if logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end
  
  get '/login/?' do
    if current_user.nil?
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end
  
  get '/logout' do
    if current_user.nil?
      session.clear
      redirect to '/'
    else
      session.clear
      redirect to '/login'
    end
  end
  
  get '/users/:slug' do
    @user = slug_name
    erb :'/tweets/show_user_tweets'
  end
  
  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect to '/signup'
    end
    @user = User.create(params)
    session[:id] = @user.id
    redirect to '/tweets'
  end
  
  patch'/login' do
    @user = User.find_by username: params[:user][:username]
    if !@user.nil? && @user.authenticate(params[:user][:password]) != false
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  post '/login' do
    @user = User.find_by username: params[:username]
    if !@user.nil? && @user.authenticate(params[:password]) != false
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

end