class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :email, :password

  def slug
    self.username.downcase.gsub(/[^0-9A-Za-z]/, '-')
  end

  def self.find_by_slug(slug)
    self.all.detect do |user|
      user.username if user.slug == slug
    end
  end
end
