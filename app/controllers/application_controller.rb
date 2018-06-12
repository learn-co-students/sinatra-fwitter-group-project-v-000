require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if params[:user].values.any? {|a| a == [] || a == "" || a == nil}
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
      if session[:user_id] == user.id
        redirect "/logout"
      else
        session[:user_id] = user.id
        "Welcome, #{user.username}!"
        redirect "/tweets"
      end
    else
      flash[:message] = "Your username/password is invalid. Please try again."
      redirect "/login"
    end
  end

  get '/logout' do
    if session[:user_id] != nil || session[:user_id] != ""
      session.clear
      flash[:message] = "You are logged out."
      redirect "/login"
    else
      redirect "/"
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    "Welcome, #{@user.name}!"
    erb :user_show
  end

  get '/tweets' do
    if session[:user_id] != nil || session[:user_id] != ""
      erb :show
    else
      redirect "/login"
    end
  end

end
