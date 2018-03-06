require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    @user = User.find_by(id: session[:id])
    if logged_in?
      # erb :'tweets/tweets'
      redirect to('/tweets')
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to('/tweets')
    else
      redirect to('/signup')
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to('/tweets')
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

  get '/tweets' do
    erb :'tweets/tweets'
  end






  helpers do
    def logged_in?
      !!session[:user_id]
    end
    def current_user
      User.find_by(id: session[:user_id])
    end
  end

end
