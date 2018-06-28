require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController
  
  use Rack::Flash

 get '/signup' do 
   erb :'/users/signup'
 end
 
 post '/signup' do 
   if !User.find_by(username: params[:username]) 
   @user = User.create(username: params[:username], email: params[:email], password: params[:password])
   session[:id] = @user.id 
   redirect to "/tweets/new"
  else 
  flash[:message] = "That username is already taken."
  redirect to "/signup"
     
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
      erb :error
    end
  end
  
 

end
