class User < ActiveRecord::Base
  has_many :tweets
  validates :username, :email, presence: true
  has_secure_password

  def slug
    self.username.downcase.gsub(/[\s\W]/, "-")
  end

  def self.find_by_slug(slug)
    self.all.detect{|user| user.slug == slug}
  end

end
