require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  #home
  get '/' do
    erb :index
  end

  #helpers

  helpers do
    #find current user if the user logged in before
    def current_user
      @user_user || =  User.find_by_id(id: session[:user_id]) if session[:user_id]
    end
   
    def logged_in?
       !!current_user
    end
     

    
  end
end
