class User < ActiveRecord::Base
  
  has_many :tweets

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.find{|user| user.slug == slug}
  end
end
