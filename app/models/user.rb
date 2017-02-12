class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  # validates_presence_of :username, :email, :password
  # changed to validate uniqueness of username and email
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password

  def slug
    username.strip.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    all.find { |user| user.slug == slug}
  end
end
