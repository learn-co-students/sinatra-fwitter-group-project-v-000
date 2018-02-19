class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    #slugify username+password
  end

  def self.find_by_slug(slug)
    #do the thing
  end
end
