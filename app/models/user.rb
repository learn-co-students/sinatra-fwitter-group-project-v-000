class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  has_many :tweet

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
