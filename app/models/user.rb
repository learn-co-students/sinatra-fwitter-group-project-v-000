class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email
  has_many :tweets

  def slug
    self.username.downcase.slug!
  end
  def self.find_by_slug(slug)
    User.all.find {|artist| artist.slug == slug}
  end
end