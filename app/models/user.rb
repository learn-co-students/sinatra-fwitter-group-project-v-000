require 'pry'
class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  
  validates :username, :password, :email, presence: true
  
  def slug
    self.username.downcase.split.join("-")
  end
  
  def self.find_by_slug(slug)
    no_slug = slug.split("-").join(" ")
    no_slug_user = User.select do |user|
      user.username.downcase == no_slug
    end
    #binding.pry
    no_slug_user[0]
  end
  
end