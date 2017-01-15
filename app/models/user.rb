class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :email, :password
  has_secure_password


  def slug
    self.username.downcase.strip.gsub(" ", "-").gsub(/[^\w-]/, "")
  end

  def self.find_by_slug(slug)
    userprime = nil
    self.all.each { |user| userprime = user if user.slug == slug }
    userprime
  end
end
