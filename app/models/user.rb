class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
      slug = self.username.downcase.split(" ").join("-")
      slug
  end

  def self.find_by_slug(slug)
      User.all.detect{ |object| object.slug == slug }
  end
end
