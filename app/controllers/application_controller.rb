require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'index'
  end



  helpers do
    def current_user(session)
      @user = User.find(session[:user_id])
    end

    def is_logged_in?(session)
      !!session[:id]
    end
  end


end
