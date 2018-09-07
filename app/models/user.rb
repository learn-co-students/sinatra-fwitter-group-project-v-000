class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
  array = self.username.split(" ")
  slug= array.join("-")
  slug
end

#.gsub(" ","-").downcase

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end

end
