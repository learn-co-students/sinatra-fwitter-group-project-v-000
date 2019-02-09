class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :email, :username, :password


  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
     self.all.find{
       |artist| artist.slug == slug}
  end


end
