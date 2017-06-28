class User < ActiveRecord::Base
  has_secure_password validations: false
  validates_presence_of :username, :email, :password
  has_many :tweets

  def slug
    self.username.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    self.all.detect{|user| user.username.downcase == slug.gsub('-', ' ')}
  end
end
