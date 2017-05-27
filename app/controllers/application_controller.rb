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

#helper method
  helpers do
     def logged_in?
       !!current_user
     end

     def current_user
       @current_user ||= User.find(session[:id]) if session[:id]
     end

  end

end
