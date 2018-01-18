require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do
    erb :index
  end

  #Helper methods
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user = User.find(id:session[:user_id])
    end
  end
end
