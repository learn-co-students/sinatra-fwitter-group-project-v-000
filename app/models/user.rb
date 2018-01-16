class User < ActiveRecord::Base
  has_many :tweets

  # before_save { self.email = email.downcase }
  # validates :username, presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, length: { maximum: 255 },
  #                 format: { with: VALID_EMAIL_REGEX },
  #                 uniqueness: { case_sensitive: false }
  has_secure_password
  # validates :password, presence: true
  # binding.pry

  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(object)
    User.all.find {|i| i.slug == object}
  end

end
