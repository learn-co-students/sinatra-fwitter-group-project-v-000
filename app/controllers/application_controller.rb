require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "some very secret word"
  end

  get "/" do
    erb :'application/welcome'
  end


  # Helper methods
  helpers do
    def current_user
      @user ||= User.find(session[:id])
    end

    def logged_in?
      !!current_user
    end
   end

end
