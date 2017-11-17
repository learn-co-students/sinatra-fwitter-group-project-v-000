class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    x = self.user_name.split(" ")
    x.join("-")
  end

  def self.find_by_slug(slugger)
    x = slugger.split("-")
    y = x.join(" ")
    User.find_by(:user_name => y)
  end
end
