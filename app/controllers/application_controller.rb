require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "programmingisfun"
  end

  get '/' do
    erb :index
  end


  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(:username => session[:username]) if session[:username]
    end

    def login(username, password)
      user = User.find_by(:username => username)
      if user && user.authenticate(password)
        session[:id] = user.id
        session[:username] = username
        redirect '/tweets'
      else
        redirect '/login'
      end
    end

    def logout!
      session.clear
    end
  end
end
