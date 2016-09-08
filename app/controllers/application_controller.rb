require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security" # --encryption key that will be used to create a 
  end

  # --home page
  get "/" do
    erb :index
  end

   helpers do
   		def logged_in?
   			!!session[:user_id]
   		end

   		def current_user
   			User.find(session[:user_id])
   		end
   	end

end
