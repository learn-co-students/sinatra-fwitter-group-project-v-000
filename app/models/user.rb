class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password

  def slug
    self.username.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.find{|n| n.slug == slug}
  end
end
