require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  helpers do
    def any_nil?(params)
      [params[:username], params[:password], params[:email]].include?("")
    end

    def logged_in?
      !!current_user
    end

    def login(username, password)
      # is the user who they claim to be
      # check if the user exists, if so set session
      user = User.find_by(username: username)
      if user && user.authenticate(password)
        # if statement assignment
        session[:username] = username

      end
      # otherwise redirect
    end

    def logout!
      session.clear
    end

    def current_user
      @current_user ||= User.find_by(:username => session[:username])
      # returns user if already set or finds and sets user
    end

  end

end
