class User < ActiveRecord::Base
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true
  has_secure_password

  def slug
    self.username.to_s.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|u| u.slug == slug}
  end

end
