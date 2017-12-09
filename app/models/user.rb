class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    slugified = self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    self.all.find { |object| object.slug == slug}
  end
end
