require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do 
    if logged_in?
      redirect to '/tweets'
    else 
      erb :index
    end 
  end 

  get '/tweets' do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = @user.tweets.all
      erb :'tweets/tweets'
    else 
      redirect '/login'
    end 
  end 

  get '/login' do 
    if logged_in?
      redirect to '/tweets'
    else 
      erb :'users/login'
    end 
  end 

  post '/login' do 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else 
      redirect to '/'
    end 
  end 

  get '/signup' do 
    if logged_in?
      redirect to '/tweets'
    else 
      erb :'users/create_user'
    end 
  end 

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if @user.save 
      session[:user_id] = @user.id 
      redirect to '/tweets'
    else 
      redirect to '/signup'
    end 
  end 

  get '/logout' do 
    if logged_in?
      session.clear 
      redirect '/login'
    else 
      redirect '/login'
    end 
  end 

  helpers do 
    def logged_in?
      !!session[:user_id]
    end 

    def current_user
      User.find(session[:user_id])
    end 
  end 
end