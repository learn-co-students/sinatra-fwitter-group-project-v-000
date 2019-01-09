class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  validates :username, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true

  def slug
    self.username.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.find {|i| i.slug == slug}
  end
end