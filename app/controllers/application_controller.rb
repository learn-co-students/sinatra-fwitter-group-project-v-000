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

    helpers do

        def logged_in? #should return true if user is logged in, otherwise false
            !!current_user
        end

        def current_user # will return the user if there is one
            @current_user ||= User.find_by(id: session[:user_id]) #slug?
        end

    end
end
