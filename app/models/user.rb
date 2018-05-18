class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password_digest
  has_many :tweets

  #TODO: Consider special characters and validating usernames, emails, and passwords
  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.detect do |user|
      user.slug == slug
    end
  end
end
