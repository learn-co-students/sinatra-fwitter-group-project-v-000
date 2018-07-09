require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController
  
  use Rack::Flash

 get '/signup' do 
   if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
       @tweets = Tweet.all
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
 end
 
 post '/signup' do 
   if !User.find_by(username: params[:username]) && params[:password] != "" && params[:email] != "" && params[:username] != ""
   @user = User.create(username: params[:username], email: params[:email], password: params[:password])
   session[:id] = @user.id 
   @tweets = Tweet.all
   redirect '/tweets'
  else 
  flash[:message] = "Please create an account."
    redirect '/signup'
  end
 end
 
  get '/login' do 
    erb :'/users/login'
  end
  
  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
		  session[:user_id] = @user.id 
		   @tweets = Tweet.all
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
       @tweets = Tweet.all
      redirect "/tweets"
    else 
      erb :error
    end
  end
  
  # get '/:slug' do
  #   @user = User.find_by_slug(params[:slug])
  #   erb :"users/show"
  # end


end
