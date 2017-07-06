require './config/environment'

class ApplicationController < Sinatra::Base
enable :sessions

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end


  helpers do
    def logged_in?
      !!session[:user_id]
    end #will return True or False

    def current_user
      logged_in? ? User.find(session[:user_id]) : nil
    end
  end

end
