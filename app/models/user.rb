class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true

  has_many :tweets


     def current_user
      User.find(session[:user_id])
     end
 
     def logged_in?
       !!session[:user_id]
     end

end