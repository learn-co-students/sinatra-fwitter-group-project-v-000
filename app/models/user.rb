class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def before_save
    username.downcase!
  end
end
