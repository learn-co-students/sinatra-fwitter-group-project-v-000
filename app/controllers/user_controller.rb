require './config/environment'

class UserController < ApplicationController
  
  get '/signup/?' do
    #binding.pry
    if session[:id].nil?
      erb :'/users/create_user'
    else
      redirect to '/tweets'
    end
  end
  
  get '/login/?' do
    #binding.pry
    @user = User.find_by id: session[:id]
    if @user.nil?
      #binding.pry
      erb :'/users/login'
    else
      redirect to '/tweets'
    end
  end
  
  get '/logout' do
    @user = User.find_by id: session[:id]
    #binding.pry
    if !@user.nil?
      session.clear
      redirect to '/login'
    else
      #binding.pry
      session.clear
      redirect to '/'
    end
    #binding.pry
  end
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/tweets/show_user_tweets'
  end
  
  post '/signup' do
    #binding.pry
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
        redirect to '/signup'
    end
    @user = User.create(params)
    session[:id] = @user.id
    #binding.pry
    redirect to '/tweets'
  end
  
  patch'/login' do
    @user = User.find_by username: params[:user][:username]
    #binding.pry
    if !@user.nil? && @user.authenticate(params[:user][:password]) != false
      session[:id] = @user.id
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end

  post '/login' do
    @user = User.find_by username: params[:username]
    #binding.pry
    if !@user.nil? && @user.authenticate(params[:password]) != false
      session[:id] = @user.id
      #binding.pry
      redirect to "/tweets"
    else
      redirect to "/login"
    end
  end
  


end