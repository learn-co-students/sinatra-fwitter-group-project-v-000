class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    slug = self.username.gsub(/[\u0080-\u00ff]/, "").gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    found = nil
    self.all.each do |user|
      if user.slug == slug
        found = user
      end
    end
    found
  end
end
