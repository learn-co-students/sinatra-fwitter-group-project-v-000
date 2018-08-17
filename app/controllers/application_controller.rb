require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET'){
      # SecureRandom.hex(64)
      "SAVE_OUTPUT_OF_ABOVE_AS_ENV_VARIABLE"
    }
  end

  get '/' do
    redirect '/login' if not logged_in?
    "Secret info"
  end 



  helpers do  

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(id: session[:user_id])
    end

  end


end
