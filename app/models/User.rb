class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.strip.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      slug == user.slug
    end
  end

end
