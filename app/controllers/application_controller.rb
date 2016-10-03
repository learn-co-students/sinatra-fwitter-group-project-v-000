require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # Password Security
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do 

    # Finds the user in the database and returns user
    def current_user(session_info)
      @user = User.find_by_id(session_info["user_id"])
    end
    # Returns true f user id is in session 
    def logged_in?(session_info)
      !!session_info["user_id"]
    end
  end

end

