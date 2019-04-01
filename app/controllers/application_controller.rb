require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "my_application_secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
<<<<<<< HEAD
      #!!session[:user_id]
      !!current_user
=======
      !!session[:user_id]
>>>>>>> c39c98be5d202e2ecf714f25d67039090863585c
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

end
