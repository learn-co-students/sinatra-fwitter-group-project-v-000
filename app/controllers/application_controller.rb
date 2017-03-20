require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
    enable :sessions
  end

  get '/' do
    erb :homepage
  end

  get '/index' do
    erb :index
  end

  #------------------LOGIN-----------------

  post '/login' do
    if User.find_by(username: params[:username])
      session[:user_id] = User.find_by(username: params[:username], password: params[:password]).id
      redirect to '/index'
    else
      erb :error
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  #-----------------CREATE-----------------

  get '/signup/new' do
    erb :signup
  end

  post '/signup' do
    @user = User.create(
    username: params[:username],
    email: params[:email],
    password: params[:password])
    redirect to "/index"
  end

  get '/tweets/new' do
    erb :tweet
  end

  #------------------READ------------------

  get '/index' do
    erb :index
  end

  #-----------------UPDATE-----------------

  #-----------------DELETE-----------------

end
