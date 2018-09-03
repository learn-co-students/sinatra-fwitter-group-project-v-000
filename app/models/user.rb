class User < ActiveRecord::Base
	has_secure_password
	has_many :tweets
	validates :username, :email, presence: true
	
	def slug
      self.username.gsub(" ", "-").downcase
    end
    
    def find_by_slug(slug)
      self.all.find{ |username| username.slug == slug }
    end
end
