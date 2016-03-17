class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  validates :username, presence: true, length: {in: 1..20}
  validates :email, presence: true
  validates :password, length: {in: 4..48}, presence: true

  def slug
    self.username.downcase.gsub(/[[$&\.\,\'\"\[\]\{\}\(\)\+\\\/\|]]/, "").gsub(/[\s]+/, "-")
  end

  def self.find_by_slug(slug_in)
    User.all.detect{|one| one.slug == slug_in}
  end
end
