require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

#renders the index page
helpers do
     def current_user
       #binding.pry
       #User.find(session[:user_id])
  @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

     end

     def logged_in?
       !!current_user
        #!!session[:user_id]
     end
    end
  end
