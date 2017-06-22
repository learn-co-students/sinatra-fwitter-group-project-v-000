require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

    #---Welcome Page---
  get '/' do
    erb :index
  end

    #--- Current User's Homepage---
  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      flash[:message] = "You don't seem to be logged in."
      redirect "/login"
    end
  end

    #---User Homepage---

  
    #---Signup---
  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:id] = user.id
      redirect '/tweets'
    else
      flash[:fields] = "You seem to be missing something..."
    end
  end

  #---Login---
  get '/login' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:passowrd])
      session[:id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

    #---Logout---
  get '/logout' do
    session.clear
    redirect '/login'
  end

  helpers do
    def current_user
      @current_user ||= User.find(session[:id])
    end

    def logged_in?
      !!session[:id]
    end

    def disabled?
      if @tweet.user.id == session[:id]
        "/tweets/<%= @tweet.id %>/delete"
      else
        ""
      end
    end
  end

end
