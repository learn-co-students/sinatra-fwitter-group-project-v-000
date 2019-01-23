require './config/environment'
# This ApplicationController will contain routes for homepage, login and signup pages.
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'bacon'
  end

# This controller may be overloaded.
# Move All this to users_controller.
# Need helper method to validate whether a user is logged in?

 
 helpers do 
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end
end