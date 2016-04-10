class User < ActiveRecord::Base
  validates_presence_of :username, :email
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(/\s+/, "-").gsub(/[^a-zA-Z0-9\-]/, "").downcase
  end

  def self.find_by_slug(slug)
    self.all.each {|a| return a if a.slug == slug}
  end
end
