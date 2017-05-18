class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end
end
