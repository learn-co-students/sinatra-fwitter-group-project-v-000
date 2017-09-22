class User < ActiveRecord::Base
	has_many :tweets

	has_secure_password

	validates :username, presence: true
	validates :email, presence: true
	validates :password, presence: true

	def slug
		title_array = self.username.split.map do |word|
			word.downcase
		end
		
		title_array.join("-")
	end

	def self.find_by_slug(slug)
		normal_name = slug.gsub(/-/, " ")
		find_by(username: normal_name)
	end
end