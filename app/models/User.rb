class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def slug
    self.username.strip.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find { |obj| obj.slug == slug }
  end
end
