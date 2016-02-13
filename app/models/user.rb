class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    found = nil
    User.all.each do |user|
      if user.slug == slug
        found = user
      end
    end
    found
  end

end
