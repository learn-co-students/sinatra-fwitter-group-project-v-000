require './config/environment'

class ApplicationController < Sinatra::Base

  enable :sessions
  set :session_secret, "secret"
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

#HOMEPAGE
  get '/' do
    erb :'/index'
  end


helpers do

    def is_logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end 
end 
