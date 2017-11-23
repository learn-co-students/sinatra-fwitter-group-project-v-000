class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ","-")
  end

  def self.find_by_slug(arg)
    new_arg = arg.gsub("-"," ")
    User.find_by(username: new_arg )
  end

end
