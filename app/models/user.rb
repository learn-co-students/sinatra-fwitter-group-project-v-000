class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  
  extend Slugifiable
  include Slugifiable
  
  def self.current_user(session)
    User.find(session[:user_id])
  end
  
  def self.logged_in?(session)
    !!session[:user_id]
  end
  
end