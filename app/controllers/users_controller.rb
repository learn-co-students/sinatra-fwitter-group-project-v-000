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
   redirect to "/#{@user.username}"
  else 
  flash[:message] = "That username is already taken."
  redirect to "/signup"
     
  end
 end
 
  get '/login' do 
    erb :'/users/login'
  end
  
  post '/login' do 
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user && @user.authenticate(params["password"])
		  session[:user_id] = @user.id 
    else 
      erb :error
    end
  end
  
  get '/:username' do 
    @user = User.find(session[:id])
    @tweets = @user.tweets.all
    erb :'/users/show'
  end

end
