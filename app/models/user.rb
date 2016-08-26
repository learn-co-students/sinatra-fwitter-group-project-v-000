class User <ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

  def self.user_exists?(username)
    User.find_by_slug(username) == username
  end
end
