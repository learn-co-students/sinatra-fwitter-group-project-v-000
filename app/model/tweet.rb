class User <ActiveRecord::Base
  has_secure_password
  belongs_to :user
 
  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Tweet.all.find{|user| user.slug == slug}
  end
end