require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, 'fwitter'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/error' do
    erb :error
  end

  helpers do

    def logged_in?
      !!session[:user]
    end

    def current_user
      session[:user]
    end

    def login(username, password)
      user = User.find_by(:username => username)
      if user && user.authenticate(password)
        session[:user] = user.username
      else
        redirect '/login'
      end
    end

    def logout!
      session.clear
    end
  end

end
