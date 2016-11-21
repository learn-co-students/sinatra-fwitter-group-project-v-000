require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do
    def current_user
      @user = User.find_by_id(session[:user_id])
    end

    def is_logged_in?
      !!session[:user_id]
    end
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    #binding.pry
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    u ||= User.new(params)
    if !u.username.empty? && !u.email.empty? && u.password_digest
      u.save
      session[:session_id] = u.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    if is_logged_in?
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do

    erb :'/tweets/create_tweet'
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end
end
