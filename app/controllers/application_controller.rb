require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'app_code'
  end

    get '/' do
      if is_logged_in?
        redirect to "/tweets"
      else
      erb :index
      end
    end

    helpers do
    def is_logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
end