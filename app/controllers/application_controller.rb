require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "special_fwitter_secret"
  end

  get '/' do
    if !is_logged_in?
      erb :index
    else
      redirect to '/tweets'
    end
  end

  helpers do

    def login(username, password)
      @user = User.find_by(username: username)
      if @user && @user.authenticate(password)
        session[:username] = @user.username
        session[:id] = @user.id
      else
        redirect '/login'
      end
    end

    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end

    def is_logged_in?
      !!current_user
    end

    def logout!
      session.clear
    end

  end

end
