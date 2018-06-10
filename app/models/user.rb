class User < ActiveRecord::Base
  has_many :tweets

  # need a method to make username a slug
  # need a class method to find a username by slug

  # the line below is the macro for passwords
  has_secure_password

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
