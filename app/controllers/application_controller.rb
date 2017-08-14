require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  	set :session_secret, "secret"
  end

  get '/' do
      if logged_in?(session)
          redirect '/tweets'
		else
			'/'
		end
  	erb :index
  end

helpers do

  def current_user(session)
		@user = User.find_by_id(session[:user_id])
	end


	#is_logged_in? should also accept the session hash as an argument.
	#This method should return true if the user_id is in the session hash and false if not.
	def logged_in?(session)
		#'!!' converts the value to a boolean. making the code statement true or false.
		!!session[:user_id]
	end
end

end