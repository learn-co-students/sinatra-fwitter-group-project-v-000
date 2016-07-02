require './config/environment'

class ApplicationController < Sinatra::Base

 configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def self.current_user(session)
      @user = User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
      !!session[:user_id]
    end
  end

end