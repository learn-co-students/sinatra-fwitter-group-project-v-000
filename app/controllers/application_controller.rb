require './config/environment'

class ApplicationController < Sinatra::Base
enable :sessions
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    # @user = current_user if is_logged_in?
    erb :index
  end

  helpers do
    def current_user(session)
      @user = User.find(session[:user_id])
    end
  
    def is_logged_in?(session)
      !!session[:user_id]
    end
  end  
end
