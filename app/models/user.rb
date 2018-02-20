class User < ActiveRecord::Base
	validates_presence_of :username, :email, :password
	has_secure_password

	has_many :tweets

	def slug
	  self.username.gsub(" ", "-")
	end

	def self.find_by_slug(username)
	  self.find_by(:username => username.gsub("-", " "))
	end

	def logged_in?
	  binding.pry
	  @user.id == session[:user_id]

	end
	# def current_user
	#   @user = User.find(session[:user_id]) if session[:user_id]
	#   # session[:user_id] == self.id
	# end
end