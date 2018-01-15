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
    erb :'/users/create_user'
  end

  post '/signup' do
    user = User.create(params[:user])
    if user.save && user.username != nil && user.username != ""
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticeate(params[:user][:password])
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  get '/tweets' do
    erb :'/users/show'
  end



  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[user_id])
    end
  end

end
