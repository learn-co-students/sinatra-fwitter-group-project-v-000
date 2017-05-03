require './config/environment'

class ApplicationController < Sinatra::Base
  enable :sessions
  set :session_secret, "fwitter_security"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
