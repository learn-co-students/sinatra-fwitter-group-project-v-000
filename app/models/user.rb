class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.strip.downcase.gsub /\W+/, '-'
  end

  def self.find_by_slug(slug)
    self.find {|obj| obj.slug == slug}
  end

  has_secure_password

end
