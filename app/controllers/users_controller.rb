require './config/environment'
require 'rack-flash'

class UsersController < ApplicationController
  
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

   get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    
    erb :'/users/user_homepage'
  end

  # Signup with a username, login, password
  # If a session is logged in - it should redirect to the users page
  get '/signup' do 
    if logged_in?  # if a user session isnt already live, populate the signup
      redirect to '/tweets'
    else
      erb :'/signup'
    end
  end

  # catches the signup params - creates a new user - and logs them into the tweets homepage
  post '/signup' do 
    if params.values.any? { |el| el.empty? }
      flash[:message] = "You need to enter all fields to signup!"
      redirect to '/signup'
    else 
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:id] = @user.id
      redirect to '/tweets'
    end
  end

  get '/login' do 
    
    if logged_in? # if a user session isnt already live, populate the signup
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do 
    @user = User.find_by(username: params[:username])
  
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Login information incorrect"
      redirect '/login'
    end
  end

  get '/logout' do 
    session.clear
    redirect to '/login'
  end




end