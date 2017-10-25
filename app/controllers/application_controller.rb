require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password"
  end

  get '/' do
    if is_logged_in?
      erb :'/tweets/tweets'
    else
      erb :index
    end
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def is_logged_in?
      !!session[:user_id]
    end
  end
end
