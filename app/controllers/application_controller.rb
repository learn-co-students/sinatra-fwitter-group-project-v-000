require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "not_secure"
  end

  helpers do

    def is_loggedin?
      !!session[:id]
    end

    def logout
      session.clear
    end

    def current_user
      User.find_by(session[:id])
    end

  end

end
