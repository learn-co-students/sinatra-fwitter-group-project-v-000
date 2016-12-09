require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end
  
  get '/' do
    erb :index
  end
  
  helpers do
    def logged_in?
      session[:id]
    end

    def current_user
      User.find_by id: logged_in?
    end

  end
  
end