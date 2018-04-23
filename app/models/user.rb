class User <ActiveRecord::Base
  #Security
  has_secure_password

  #Relationship
  has_many :tweets

  #Slug
  def slug
    username.downcase.gsub(" ","-")

  end

  def self.find_by_slug(slug)
    self.all.find{|u| u.slug == slug}
  end

end
