class User < ActiveRecord::Base
  belongs_to :user
  has_secure_password

  def slug
    self.username.downcase.strip.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find do |u|
      u.slug == slug
    end
  end

end
