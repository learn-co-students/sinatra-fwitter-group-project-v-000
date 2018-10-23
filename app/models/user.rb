class User < ActiveRecord::Base

  has_many :tweets
  has_secure_password
  def self.find_by_slug(slug)
    User.all.find do |user|

      user.slug == slug
    end
  end

  def slug
    self.username.downcase.gsub(' ','-')
  end
end
