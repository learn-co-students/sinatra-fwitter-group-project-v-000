class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    #binding.pry
     self.all.find do |item|
       item.slug == slug
     end
   end

end
