require "./config/environment"
require "./app/models/user"
require "./app/models/tweet"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_secret"
  end

  before do
     pass if ["login", "signup", nil].include? request.path_info.split('/')[1]
     if !logged_in?
       redirect '/'
     end
  end

#-------- Landing page --------

  get '/' do
    erb :index
  end

  helpers do
  		def logged_in?
  			!!current_user
  		end

  		def current_user
  			@current_user ||= User.find(session[:id]) if session[:id]
  		end
  	end

end
