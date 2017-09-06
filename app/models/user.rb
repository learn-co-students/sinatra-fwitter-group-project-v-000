class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, presence: true
  validates :email, presence: true

  def slug
    self.username.downcase.split(' ').join('-')
  end

  def self.find_by_slug(slug)
    User.all.find { |user| user.slug == slug }
  end
end
