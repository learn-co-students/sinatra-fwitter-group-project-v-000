require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if !params[:email].empty? && !params[:username].empty? && !params[:password].empty? && @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
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
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
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

  get '/users/:username' do
    @user = User.find_by(username: params[:username])
    erb :'users/show'
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
