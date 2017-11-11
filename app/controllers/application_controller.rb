# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "spicy pickle"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/signup'
    end
  end

  post '/signup' do
    if !params[:username].empty? and !params[:email].empty? and !params[:password].empty?
      user = User.create(params)
      session[:user_id] = user.id
    else
      redirect '/signup'
    end
    redirect '/tweets'
  end

  get '/login' do
    erb :'/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/failure'
    end
  end

  post '/logout' do
    session.clear
    redirect '/'
  end

  get '/tweets' do

    erb :tweets
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
