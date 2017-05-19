class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  # validations for username, email, pswd, w/ min pswd length
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, length: { minimum: 8}

  def slug
    username.strip.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    all.find { |user| user.slug == slug }
  end
end
