require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "something_secret"
  end

  get '/' do
    if logged_in?
      redirect "/tweets"
    else
      erb :index
    end
  end

  register do
    def auth (type)
      condition do
        redirect "/login" unless send("#{type}")
      end
    end
  end #register

  helpers do
		def logged_in?
      !!current_user
		end

		def current_user
			@current_user ||= User.find(session[:user_id]) if session[:user_id]
		end
	end #helpers

end
