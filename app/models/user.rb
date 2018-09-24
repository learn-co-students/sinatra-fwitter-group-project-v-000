class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    name = self.username
    slugged = name.downcase.gsub(" ", '-')
    slugged
end

def self.find_by_slug(slug)
    name = slug.split('-').join(" ")
    self.all.detect{|i| i.username.downcase == name}
end

end