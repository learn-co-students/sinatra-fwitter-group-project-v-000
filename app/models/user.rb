class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.split(" ").join("-")
  end

  def self.find_by_slug(text)
    User.all.find {|user| user.slug == text}
  end
end