class User < ActiveRecord::Base
    has_secure_password
    has_many :tweets

    def slug
		a = []
		a = self.username.split(" ")
		a.join("-").downcase
	end

	def self.find_by_slug(slug)
		a = []
		name = ""
		a = slug.split("-")
		a.each do |s|
			name << s + " "
		end
		User.find_by(username: name.strip)
	end
end