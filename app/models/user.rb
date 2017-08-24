class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets


  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.each do |user|
      if user.slug == slug
        return user
      end
    end
  end

end
