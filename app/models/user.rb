class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.split(' ').join('-').downcase
  end

  def self.find_by_slug(slug)
    User.all.select {|user| user.slug == slug}[0]
  end
end