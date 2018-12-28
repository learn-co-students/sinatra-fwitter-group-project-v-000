require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "blah-blah-blah-bitty"
  end

  get "/" do
    "Welcome to Fwitter"
  end

  helpers do

    def current_user
      @user = User.find_by_id(session[:user_id])
    end

    def is_logged_in?
      !!session.include?(:user_id)
    end
    
    def login(user_id)
      session[:user_id] = user_id
    end 
    
    def logout 
      session.clear
    end 
 
  end 
 
end 

