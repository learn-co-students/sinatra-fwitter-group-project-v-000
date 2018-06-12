class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    a = self.name.downcase.split(" ")
    a_slug = a.join("-")
  end

  def self.find_by_slug(slug)
    self.all.find{|a|a.slug == slug}
  end
end
