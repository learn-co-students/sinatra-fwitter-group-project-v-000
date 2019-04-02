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
      #!!session[:user_id]
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(session[:user_id]) if session[:user_id]
      #User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

end
