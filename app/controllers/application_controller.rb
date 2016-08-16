require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "twitter"
  end

  get '/' do 
    erb :index
  end

  helpers do 

    def is_logged_in?
      !!current_user
    end

    def login(email, id)
      if user = User.find_by(:id => id)
        if user.authenticate(password)
          session[:id] = user.id
      else 
        redirect '/login'
    end
  end
  end

    def current_user
      @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
    end 

    def logout!  
      session.clear
    end 

  end 


end
