class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :email, on: :create
  validates_presence_of :username, on: :create
  validates_presence_of :password, on: :create

  def slug
    self.username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.detect do |user|
      slug == user.slug
    end
  end
end
