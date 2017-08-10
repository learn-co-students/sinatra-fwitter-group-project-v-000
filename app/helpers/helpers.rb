class Helpers
	def current_user
	 if session[:user_id] != nil
	 	User.find_by_id(session[:user_id])
	 end
	end

	def logged_in?
		!!current_user
	end
end