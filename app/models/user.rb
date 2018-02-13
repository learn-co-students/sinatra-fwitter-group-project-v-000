class User < ActiveRecord::Base

  has_secure_password
  validates :username, :presence => true

  has_many :tweets

  def slug
    name_array = username.downcase.split(" ")
    name_array.join("-")
  end

  def self.find_by_slug(slug)
    User.all.detect {|user| user.slug == slug }
  end

end