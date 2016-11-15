class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ","-")
  end

  def self.find_by_slug(arg)
    #test-123 > test 123
    new_arg = arg.gsub("-"," ")
    User.find_by(username: new_arg )
    #binding.pry
  end
end
