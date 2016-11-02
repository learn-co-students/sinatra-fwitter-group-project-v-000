class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |object|
      object.username.downcase.gsub(" ", "-") == slug
    end
  end
end
