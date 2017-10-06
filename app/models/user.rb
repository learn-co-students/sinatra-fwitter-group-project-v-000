class User < ActiveRecord::Base
  has_secure_password

  has_many :tweets

  validates :username, :presence => true
  # user instance must have @username attribute to be successfully saved to DB
  validates :email, :presence => true
  # user instance must have @email attribute to be successfully saved to DB
  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.detect {|user| user.slug == slug}
  end
end
