class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :password, :email
  has_secure_password
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{ |instance| instance.slug == slug }
  end

end
