class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.scan(/[a-z0-9]+/).join('-')
  end

  def self.find_by_slug(slug)
    self.all.find { |e| e.slug == slug }
  end
end
