require 'rack-flash'
class UserController < ApplicationController
use Rack::Flash
  get '/' do
    @user = current_user
  	erb :index
  end 

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else 
      erb :'users/create_user'
    end 
  end 

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty? || !is_an_email?
      flash[:message] = "You must enter a valid username, email and password"
      redirect '/signup'
    else
    	@user = User.find_by(username: params[:username])
    	if @user == nil
    		@user = User.create(params)
    		session[:user_id] = @user.id
    		redirect '/tweets'
    	else 
    		flash[:message] = "That user already exists"
    		redirect '/signup'
    	end 
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
    @user = User.find_by(username: params[:username]).authenticate(params[:password])
    if @user == false 
      redirect '/login'
    else
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end 

  get '/logout' do
    session.clear
    redirect '/login'
  end 

  get '/users/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	@user_tweets = Tweet.all.select{|t| t.user_id ==@user.id}
  	erb :'users/show_user'
  end

end 