class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password
  validates :username, presence: true
  validates :email, presence: true

  def slug
    self.username.downcase.gsub(" ", "-") if self.username
  end

  def self.find_by_slug(slug)
    self.all.select {|user| user.slug == slug}.first
  end

end