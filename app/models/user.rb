class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{ |instance| instance.slug == slug }
  end

  has_secure_password
end
