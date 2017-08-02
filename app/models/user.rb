class User < ActiveRecord::Base
  
  has_many :tweets
  has_secure_password
  validates :username, :email, :password, presence: true

  def self.find_by_slug(slug)
    self.all.detect { |instance| instance.slug == slug }
  end

  def slug
    self.username.gsub(" ", "-").downcase
  end

end