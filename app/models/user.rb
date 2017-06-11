class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
   self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(param)
User.all.find{|s| s.slug == param}
  end

end
