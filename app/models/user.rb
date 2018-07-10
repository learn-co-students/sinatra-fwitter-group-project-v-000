class User < ActiveRecord::Base
  has_many :tweets

  validates_presence_of :username, :email, :password
  has_secure_password

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find { |s| s.slug == slug }
    #self.all.detect { |s| s.slug == slug }
    #=> #detect and #find are two names for the same method
  end


end
