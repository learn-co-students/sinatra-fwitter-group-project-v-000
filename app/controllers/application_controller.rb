require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions # required to store session[:id]
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do # helper methods to check if user is logged_in and to retrieve current_user
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
