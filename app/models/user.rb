class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.downcase.tr(" ","-")
  end

  def self.find_by_slug(slug_name)
    User.all.find {|un| un.slug == slug_name}
  end
end
