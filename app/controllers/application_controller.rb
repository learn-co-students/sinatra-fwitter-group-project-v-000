require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "bar_bouncer"
  end

  get '/' do
    erb :home
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      # Possibly trouble because of User vs @user???
      User.find(session[:user_id])
    end
  end

end
