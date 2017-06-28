require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ho7do9h4m6urg3r"
  end

  get '/' do
    erb :index
  end

  helpers do
    def signed_in?
      !!session[:id]
    end

    def current_user
      if signed_in?
        User.find_by_id(session[:id])
      end
    end
    
  end
end
