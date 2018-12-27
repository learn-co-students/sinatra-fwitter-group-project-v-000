class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.strip.gsub(' ', '-')
  end

  def self.find_by_slug(slug_version)
  self.all.each do |user|
    if user.slug == slug_version
      return user
      end
    end
  end

end
