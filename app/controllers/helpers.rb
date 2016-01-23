module Helpers
	def self.available
		true
	end

	def self.can_edit?(session, tweet)
		#binding.pry
		if session[:id]
			tweet.user.id==User.find(session[:id]).id
		else
			false
		end
	end

	def self.modify_tweet(tweet, params)
		#binding.pry
		tweet.content=params[:content]
		tweet.save

	end

	def self.valid_login(params)
		!!User.find_by(username: params[:username], password: params[:password])
	end

	def self.login(user, session)
		#binding.pry
		#puts "Loggin in user #{user.id}"
		session[:id]=user.id
	end

	def self.login_by_params(params, session)
		id = User.find_by(username: params[:username], password: params[:password]).id
		#puts "Loggin in user #{id}"
		session[:id]=id
	end

	def self.logged_in?(session)
		#puts "ALREADY LOGGED IN" if !!(session[:id])
		!!(session[:id])
	end

	def self.signup_params_valid?(p)
		(p[:username]=="" || p[:password]=="" || p[:email]=="") ? false : true
	end

	def self.current_user(session)
		User.find(session[:id])
	end

	def self.user_by_slug(slug)
		binding.pry
	end
	
end