require './config/environment'

class ApplicationController < Sinatra::Base
  
  Rack::MethodOverride 

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
	configure do
	enable :sessions
	set :session_secret, "secret"
	end
	
	get '/' do 
	 if Helpers.is_logged_in?(session)
    @user = Helpers.current_user(session)
    @tweets = Tweet.all
    redirect to "/users/#{@user.username}"
  else 
    erb :index
  end
  end


end
