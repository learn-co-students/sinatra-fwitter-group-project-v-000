class User < ActiveRecord::Base
  has_secure_password
  #validates_presence_of :username, :email, :password_digest 
  has_many :tweets

end

class Helpers < ActiveRecord::Base

  def self.current_user(user)
    @user = User.find_by(id: user[:user_id])
  end

  def self.is_logged_in?(user)
    if user[:user_id]
      true
    else
      false
    end
  end

end
