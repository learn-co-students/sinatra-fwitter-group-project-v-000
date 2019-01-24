require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "secure_password"
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user(session)
      @user = User.find_by_id(session[:user_id])
    end

    def is_logged_in?(session)
      !!current_user(session)
    end
  end

end
