class User < ActiveRecord::Base
	has_secure_password
	has_many :tweets

	def slug
		input = self.username.downcase.split.collect{|string|string.scan(/[a-z0-9]/)}
		input.collect {|arr|arr.join("")}.join('-')
	end

	def self.find_by_slug(slug)
		collection = self.all
		collection.find {|instance| instance.slug == slug}
	end

end