class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :email, :password
  has_many :tweets

  def slug
    self.username.gsub(" ","-")
  end

  def self.find_by_slug(arg)
    new_arg = arg.gsub("-"," ")
    User.find_by(username: new_arg )
  end

  def self.current_user(session_hash)
    @user = User.find_by_id(session_hash[:user_id])
  end

  def self.is_logged_in?(session_hash)
    !!session_hash[:user_id]
  end
end
