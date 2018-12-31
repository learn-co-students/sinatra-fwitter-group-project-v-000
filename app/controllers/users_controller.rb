class UsersController < ApplicationController

  get '/signup' do 
    if logged_in?
      redirect "/tweets" 
    else 
      erb :"/users/create_user"
    end 
  end 
  
  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id 
      redirect "/tweets"
    else 
      redirect "/signup"
    end 
  end 
  
  get '/login' do
    if logged_in?
      redirect "/tweets"
    else 
      erb :"/users/login"
    end 
  end 
  
  post '/login' do
    #binding.pry 
    user = User.find_by(username: params[:username])
    if !!user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect "/tweets"
    else
      redirect "/login"
    end 
  end 
  
  get '/users/:id' do
    @user = User.find(params[:id])
    if !!session[:user_id]
      erb :"/users/show"
    else 
      redirect '/'
    end 
  end 
  
  get '/logout' do
    #binding.pry
    if logged_in?
      session.clear
      redirect :"/login" 
    else 
      redirect "/login"
    end 
  end 
end

