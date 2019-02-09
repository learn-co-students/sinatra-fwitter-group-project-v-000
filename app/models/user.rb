class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    # This method seems unnecessary since we have the 'current_user' helper method.
    self.all.find {|u| u.slug == slug}
  end

end