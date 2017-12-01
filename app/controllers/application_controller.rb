require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end


  helpers do

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end

    def login(email)
      if user = User.find_by(:email => email)
        session[:user_id] = user.id
      else
        redirect '/login'
      end
    end

    def logout!
      session.clear
    end
  end
end