require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :index
  end

  helpers do
    def current_user(arg)
      @user = User.find_by(id: arg[:id])
      @user
    end

    def is_logged_in?(arg)
      !!arg[:id]
    end
  end


end
