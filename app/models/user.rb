class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password #need to add this here in order to use bcrypt and have the .authenticate method available

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
