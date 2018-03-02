class User < ActiveRecord::Base
  extend Slugifiable::FindableBySlug

  has_secure_password
  validates_presence_of :username, :email, :password
  has_many :tweets

  def slug
    self.username.downcase.gsub(/ /, "-")
  end
end
