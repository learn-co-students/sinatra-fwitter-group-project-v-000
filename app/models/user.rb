class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    if username
      [username.parameterize].join("-")
    end
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end

end
