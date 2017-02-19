require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "fwitter_secret_sessions"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    session[:user_id] = 1
    erb :'users/create_user'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find session[:user_id]
    end
  end
end
