class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :email, :password

  has_secure_password

  def slug
    self.username.gsub(' ','-').downcase
  end

  def self.find_by_slug(slug)
    all.detect {|x| x.slug == slug}
  end

end
