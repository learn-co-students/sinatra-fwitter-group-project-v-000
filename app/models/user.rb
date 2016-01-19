class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    users_by_slug = users.map{|user| [user.slug, user]}.to_h
    users_by_slug[slug]
  end

end