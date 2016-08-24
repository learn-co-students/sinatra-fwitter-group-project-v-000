class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  validates_presence_of :username

  def  slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.detect{|u|u.slug == slug}
  end
end
