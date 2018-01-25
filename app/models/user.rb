class User < ActiveRecord::Base
  has_many :tweets

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  has_secure_password

  def slug
    self.username.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    username = slug.split("-").join(" ")
    self.where('username = ?', username).first
  end

end
