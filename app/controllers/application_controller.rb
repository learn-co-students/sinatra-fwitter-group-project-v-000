require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'views/index'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      User.find(session[:user_id]) if session[:user_id]
    end
  end

end
