module Sinatra
	module SessionHelpers
		def current_user
			@user = User.find_by(id: session[:id])
		end

		def logged_in?
			!!session[:id]
		end

		def current_user?(user)
			current_user && current_user.id == user.id
		end
	end
	helpers SessionHelpers
end
