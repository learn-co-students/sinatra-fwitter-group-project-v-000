class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :email, :password

  def slug
    self.username.split(" ").join("-").downcase
  end

  def self.find_by_slug(input)
    self.all.detect {|instance| instance.slug == input}     
  end
end