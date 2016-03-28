class User < ActiveRecord::Base
  has_secure_password

  def slug
    username.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    User.find_by(username: slug.gsub('-',' '))
  end
end
