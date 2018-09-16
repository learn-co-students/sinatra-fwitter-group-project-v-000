require_relative './concerns/slugifiable'

class User < ActiveRecord::Base

# include Slugifiable::InstanceMethods
# include Slugifiable::ClassMethods

 #validates_presence_of :username, :email, :password
 has_secure_password
 has_many :tweets

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug (slug)
    User.all.find { |name| name.slug == slug }
  end
end
