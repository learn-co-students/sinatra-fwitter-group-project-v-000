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



  helpers do  

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(id: session[:user_id])
    end

    def time_of_day
      hour = Time.now.to_s.split(" ")[1].split(":")[0].to_i
      if hour < 12
        "Morning"
      elsif hour < 17
        "Afternoon"
      else
        "Evening"
      end
    end

    def authorize
      if !logged_in? || current_user.nil?
        redirect '/login'
      end
    end

  end


end
