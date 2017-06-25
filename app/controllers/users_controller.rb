require 'rack-flash'
class UsersController < ApplicationController

use Rack::Flash

  get '/signup' do
    @session = session
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    @session = session
    @session[:user_id] = @user.id
    if logged_in? && !params[:username].empty? && !params[:password].empty? && !params[:email].empty?
      redirect '/tweets'
    else
      flash[:message] = "You must have username, email, and password to sign up. Please fill in all three."

    	redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
  	@user = User.find_by(username: params[:username])
  	if @user && @user.authenticate(params[:password])
      @session = session
  		@session[:user_id] = @user.id
  		redirect "/tweets"
  	else
      flash[:message] = "That username and/or password did not match what we have on record. Please try again."
  		erb :'/users/login'
  	end
  end

  get '/logout' do
    session.delete(:user_id)
    redirect '/login'
  end

end