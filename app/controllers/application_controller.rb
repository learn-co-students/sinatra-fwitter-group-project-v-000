require './config/environment'

class ApplicationController < Sinatra::Base

  enable :sessions
  set :session_secret, "tweety bird"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!current_user
    end
  end

end
