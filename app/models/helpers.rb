class Helpers 
	def self.valid_submission(sub)
		!sub[:username].empty? && !sub[:email].empty? && !sub[:password].empty?
	end
	
	def self.signed_in?(session)
		!session[:id].nil?
	end
	
end