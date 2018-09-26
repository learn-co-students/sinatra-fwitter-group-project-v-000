class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.split.join("-")
  end

  def self.find_by_slug(slug)
    User.all.find{|u| u.slug == slug}
  end

end
