require './config/environment'
require '/sinatra/flash'
class UsersController < ApplicationController
  enable :sessions
  set :session_secret, "secret"
  register Sinatra::Flash

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:user].any? {|a| a == [] || a == "" || a == nil}
      flash[:message] = "Your username/password/email is invalid. Please try again."
      redirect "/signup"
    else
      User.create(params[:user])
      redirect "/tweets"
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      flash[:message] = "Your username/password is invalid. Please try again."
      redirect "/login"
    end
  end

end
