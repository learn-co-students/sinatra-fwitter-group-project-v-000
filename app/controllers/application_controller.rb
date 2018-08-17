require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "dumb_word"
  end

  get "/" do
    erb :index
  end

  helpers do
		def logged_in?
			session[:user_id] != nil
		end

		def current_user
		  if session[:user_id]
			  User.find(session[:user_id])
			end
		end
  end

end
