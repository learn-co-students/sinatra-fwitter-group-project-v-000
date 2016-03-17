require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_application_secret"
  end



  helpers do

    def logged_in?
      !!session[:id]
    end

    def username_exist?
      username = User.find_by(username: params[:username])
      !!username
    end

    def email_exist?
      email = User.find_by(email: params[:email])
      !!email
    end

    def logout!
      session.clear
    end

  end #End of  helpers

end
