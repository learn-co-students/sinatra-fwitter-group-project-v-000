class User < ActiveRecord::Base
	has_many :tweets

	def slug
		self.username.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)
		self.all.find {|inst| inst.slug == slug}
	end

	def authenticate(password)
		if self.password == password
			self
		else
			false
		end
	end

end