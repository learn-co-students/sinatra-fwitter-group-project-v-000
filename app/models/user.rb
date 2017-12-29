class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def find_by_slug(slug)
    self.all.find {|e| e.slug == slug}
  end
end
