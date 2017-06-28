class User < ActiveRecord::Base
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  has_secure_password

  def slug
    name_array = username.downcase.split
    name_slug = name_array.join("-")
  end

  def self.find_by_slug(slug)
    name = slug.gsub("-", " ")
    self.find_by('lower(username) = ?', name)
  end
end
