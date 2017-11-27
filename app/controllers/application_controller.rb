require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
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

    def current_user
      @current_user = User.find(session[:user_id]) if session[:user_id]
    end

    def logout!
      session.clear
    end
  end



end
