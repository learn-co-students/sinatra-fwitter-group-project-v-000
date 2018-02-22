class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.gsub(/[^a-z0-9]+/, "-").downcase
  end

  def self.find_by_slug(slug)
    User.all.detect{|user| user.slug == slug}
  end
end
