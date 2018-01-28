class User < ActiveRecord::Base
  # has_secure_password
  has_many :tweets

  def slug

  end

end
