class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :email
  attr_accessor :name

  def slug
    self.username.gsub(" ", "-").downcase
  end   

  
  def self.find_by_slug(slug)
    self.all.find do |instance| 
      instance.slug == slug 
    end
  end
end