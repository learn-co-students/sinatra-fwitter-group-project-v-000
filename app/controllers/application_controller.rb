require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions_secret, "my_application_secret"

    #register Sinatra::Twitter::Bootstrap::Assets
    enable :sessions
  end

    get '/' do
      erb :index
    end

    def logged_in?
         session[:user_id]
    end
end
