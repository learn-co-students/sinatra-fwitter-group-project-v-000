class User < ActiveRecord::Base
  include ActiveRecord::Validations
  has_many :tweets
  has_secure_password
  validates_presence_of :username

  def slug
  	self.username.slugify
  end

  def self.find_by_slug(slug)
    User.all.detect{|user| user.slug == slug}
  end

end
