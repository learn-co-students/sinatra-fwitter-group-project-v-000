class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets


  def slug
    unless self.username.nil?
      self.username.gsub(" ", "-").downcase
    end
  end

  def self.find_by_slug(slug)
    self.all.find{ |instance| instance.slug == slug }
  end
end
