require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
  	enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  	erb :index
  end

  helpers do
		def logged_in?
			!!session[:id]
		end

		def current_user
			User.find_by_id(session[:id])
		end
	end

end