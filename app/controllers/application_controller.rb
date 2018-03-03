require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
  end


	get '/' do 
		flash[:message] = "Home is where the heart is"
		erb :'/index'
	end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def filled_out(params)
      params.none? {|k,v| v.empty?}
    end

		def not_filled_out
			flash[:message] = "The form was incomplete or not filled out correctly"
		end

		def please_login
			flash[:message] = "Please log in to do that."
		end
		
		def success
			flash[:message] = "Success"
		end

		def failure
			flash[:message] = "Failure."
		end


  end


end
