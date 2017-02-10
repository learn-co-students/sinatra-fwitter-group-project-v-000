class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.strip.downcase.tr(' ', '-')
  end

  def self.find_by_slug(slug)
    all.find { |user| user.slug == slug}
  end
end
