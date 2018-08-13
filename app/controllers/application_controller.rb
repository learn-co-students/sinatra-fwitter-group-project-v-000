require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :Sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user(session)
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login(user_id)
      session[:user_id] = user_id
    end

    def logout!
      session.clear
    end

  end

end
