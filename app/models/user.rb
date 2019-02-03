class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  # Helper Methods
  def current_user

  end

  def logged_in?

  end

end