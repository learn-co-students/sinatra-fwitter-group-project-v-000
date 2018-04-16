class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.downcase.gsub(/\s+/, '-')
  end

  def self.find_by_slug(slug)
    self.all.detect {|element| element.slug == slug}
  end

  has_secure_password
end
