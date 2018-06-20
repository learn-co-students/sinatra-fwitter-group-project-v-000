require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

#load homepage to show links to login or sign up
  get '/' do
    erb :index
  end

#helper methods
  helpers do
    def current_user
      if session[:user_id] #if there is a valid session user_id
        @current_user = User.find_by(:id => session[:user_id])
      end
    end

    def logged_in?
      !!current_user #if current user is true
    end
  end

end
