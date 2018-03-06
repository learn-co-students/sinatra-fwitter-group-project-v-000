class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username
  validates :email, uniqueness: true
  has_many :tweets




  def self.find_by_slug(slug)
    self.all.find{|obj| obj.slug == slug}
  end


  def slug
    self.username.downcase.gsub(" ", "-")
  end
end
