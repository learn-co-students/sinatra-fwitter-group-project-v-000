class User < ActiveRecord::Base

  has_secure_password
  validates_presence_of :username, :email, :password_digest
  has_many :tweets

  def slug
    self.username.downcase.gsub(/ /, "-")
  end

  def self.find_by_slug(slug)
    self.all.find do |object|
      object.slug == slug
    end
  end
end
