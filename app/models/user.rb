class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, :email, presence: true, uniqueness: true
  validates :password, presence: true

  def slug
    self.username.downcase.gsub(/[\s\W]/," "=>"-")
  end

  def self.find_by_slug(slug)
    self.all.detect{|x| x.slug == slug}
  end
end
