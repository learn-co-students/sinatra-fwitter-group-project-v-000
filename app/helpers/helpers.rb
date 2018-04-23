class Helpers

	def self.current_user
		User.find(id: session[:user_id])
	end

	def self.logged_in?
		!!session[:user_id]
	end

end