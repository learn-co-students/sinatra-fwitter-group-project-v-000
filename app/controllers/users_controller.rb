require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController
  
  use Rack::Flash

 get '/signup' do 
   erb :'/users/signup'
 end
 
 post '/signup' do 
   if !User.find_by(username: params[:username]) && params[:password] != "" && params[:email] != "" && params[:username] != ""
   @user = User.create(username: params[:username], email: params[:email], password: params[:password])
   session[:id] = @user.id 
   redirect '/tweets'
  else 
  flash[:message] = "Please create an account."
    redirect '/tweets'
  end
 end
 
  get '/login' do 
    erb :'/users/login'
  end
  
  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
		  session[:user_id] = @user.id 
		  redirect to '/tweets'
    else 
       flash[:message] = "The username or password is incorrect."
       redirect to '/login'
    end
  end
  
  get '/logout' do 
    session.clear
    redirect '/login'
  end
 
  get '/login' do 
    erb :'/sessions/login'
  end
  
  post '/login' do 
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user 
      session[:user_id] = @user.id
      redirect "/#{@user.username}"
    else 
      erb :error
    end
  end



end
