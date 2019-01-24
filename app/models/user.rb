class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, :email, presence: true

  def self.find_by_slug(slug)
    User.all.detect { |user| user.slug == slug }
  end

  def slug
    username.split.join("-")
  end
end
