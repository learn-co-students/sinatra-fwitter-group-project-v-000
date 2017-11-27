require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    # enable sessions to check current user
    enable :sessions unless test?
    set :session_secret, 'super_secret_phrase'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  ## Helpers ##

  helpers do
    def logged_in?
      !!current_user
    end

    # Find the current_user by finding their session[:user_id] if one exists #
    def current_user
      @current_user = User.find(session[:user_id]) if session[:user_id]
    end

    # Logout method to clear the session #
    def logout!
      session.clear
    end
  end



end
