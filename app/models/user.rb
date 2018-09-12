class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.gsub(' ', '-').downcase
  end

  def self.find_by_slug(slug)
    self.all.find {|name| name.slug == slug}
  end
end
