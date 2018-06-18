class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ","-")
  end

  def self.find_by_slug(path)
    User.all.detect {|u| u.username.downcase == path.downcase.gsub("-"," ")}
  end

end
