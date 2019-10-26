require 'slugify'

class User < ActiveRecord::Base
  has_secure_password
  validates :email, :username, presence: true

  has_many :tweets

  def slug
    username.slugify
  end

  def self.find_by_slug(slug)
    User.all.find{ |user| user.slug == slug }
  end
end
