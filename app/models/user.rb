class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username


  def slug
    self.username.downcase.tr(" ","-")
  end

  def self.find_by_slug(slug_name)
    User.all.find {|un| un.slug == slug_name}
  end
end
