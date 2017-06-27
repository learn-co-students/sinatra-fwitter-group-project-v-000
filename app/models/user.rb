class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
  end

  def find_by_slug
  end

end
