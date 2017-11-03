class User < ActiveRecord::Base

	has_secure_password
	has_many :tweets


	def slug
		self.username.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)
		User.all.find {|user| user.slug == slug}
	end

	def logged_in?
		!!current_user
	end

	def self.current_user
		@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
	end
end