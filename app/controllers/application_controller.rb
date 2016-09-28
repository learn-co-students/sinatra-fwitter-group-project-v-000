require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do 
    if session[:user_id]
      redirect to 'tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params["username"].empty? || params["password"].empty? || params["email"].empty?
      redirect to '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to '/tweets'
    end
  end

  get '/login' do 
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params["username"])
    if user.password == params["password"]
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      "Wrong Password"
      redirect to '/login'
    end
  end

  get '/tweets' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/login'
  end








end