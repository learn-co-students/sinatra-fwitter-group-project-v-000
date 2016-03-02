class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true

  has_many :tweets


   def slug
     username.downcase.split(" ").join("-")
   end
 
   def self.find_by_slug(slug)
     all.find{ |user| user.slug == slug }
   end  

end