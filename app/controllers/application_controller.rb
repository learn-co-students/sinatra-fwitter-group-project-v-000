require './config/environment'


class ApplicationController < Sinatra::Base
	use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  	set :session_secret, "secret"
  end

  get '/' do 
  	erb :index
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end

		def slug
			self.name.downcase.split(" ").join("-")
		end

		def self.find_by_slug(slug)
			self.all.detect do |instance|
				instance.slug == slug	
			end
		end
		
	end

end