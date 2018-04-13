class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slugified_username)
    self.all.find do |x|
      x.slug == slugified_username
    end
  end
end
