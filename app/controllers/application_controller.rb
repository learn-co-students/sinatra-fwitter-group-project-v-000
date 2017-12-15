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
    redirect '/tweets'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    redirect '/tweets'
  end



  helpers do

    def logged_in?

    end

    def current_user

    end

    def logout
      session.clear
    end

  end
end
