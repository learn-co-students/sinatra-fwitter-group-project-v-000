require './config/environment'

class ApplicationController < Sinatra::Base
# enable :sessions
  
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
    def current_user
      # binding.pry
      @user = User.find(session[:user_id])
    end
  
    def is_logged_in?
      !!session[:user_id]
    end

  end  

end
