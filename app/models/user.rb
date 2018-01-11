class User < ActiveRecord::Base

  has_secure_password

  has_many :tweets

  validates :username, presence: true, allow_blank: false
  # validates :username, uniqueness: true

  validates :email, presence: true
  # validates :email, uniqueness: true

  validates :password, presence: true

  validates :password_digest, presence: true

  def slug
    self.username.downcase.split(/\s|\.\W/).join("-")
  end

  def self.find_by_slug(slug)
    self.all.each do |user|
      return user if user.slug == slug
    end
  end

end
