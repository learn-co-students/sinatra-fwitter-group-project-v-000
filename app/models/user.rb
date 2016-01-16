class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  
  def slug
    @username.downcase.gsub(" ", "-")
  end
end