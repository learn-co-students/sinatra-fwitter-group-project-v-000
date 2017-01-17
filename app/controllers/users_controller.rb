require 'pry'
class UsersController < ApplicationController

  get '/signup' do
    if logged_in? 
      erb :'/tweets/tweets'
    else    
      erb :'users/create_user'
    end  
  end   

  post '/signup' do 
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to '/signup'
    else  
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    end 
  end  

  get '/login' do 
    if logged_in?
      redirect to '/tweets'
    else
      erb :'users/login'
    end  
  end  

  post '/login' do 
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session_id = @user.id
      redirect to '/tweets'
    else
      redirect to '/login'  
    end  
  end  

  get '/tweets' do 

    erb :'tweets/tweets'
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