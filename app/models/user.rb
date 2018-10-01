class User < ActiveRecord::Base
   has_secure_password
   has_many :tweets

   def slug
      self.username.downcase.gsub(" ", "-")
   end

   def self.find_by_slug(username)
      self.find {|i| i.slug == username}
   end
end
