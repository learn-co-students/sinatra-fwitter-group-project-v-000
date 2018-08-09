class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    self.username.gsub(" ","-")
  end

  def self.find_by_slug(slug_phrase)
    self.find{|user| user.slug == slug_phrase}
  end
end
