class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  #Create an **instance** method slug to slugify the username
  #Create a **Class** method to find by slug
  #Hint

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    all.find do |username|
    username.slug == slug
    end
  end
end
