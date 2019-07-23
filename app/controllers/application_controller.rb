require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions 
    set :views, 'app/views'
    set :session_secret, "fwitter_secret"
  end
  
  get '/' do 
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end 

end
