require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
      #!!current_user
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be loggin in to view that page."
        redirect "/login"
      end
    end

    def authorized_to_edit?(tweet)
      tweet.user == current_user
    end
  end

end
