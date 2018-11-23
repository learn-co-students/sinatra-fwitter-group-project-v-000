require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
    # so the user doesnt have to log in log out all the time
  end

  get '/' do
    'Hello World!'
    #binding.pry
    erb :'index'
  end

  helpers do #review helpers section

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end


  end

end
