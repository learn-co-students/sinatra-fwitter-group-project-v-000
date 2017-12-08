class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, :presence => true,
                       :uniqueness => true
  validates :email,    :presence => true,
                       :uniqueness => true
  validates :password, :presence => true

  def self.authenticate(params)
    user = User.find_by_name(params[:username])
    (user && user.password == params[:password]) ? user : nil
  end

  def self.logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    User.find(session[:user_id]) if session[:user_id]
  end

  def slug
    self.username.split(" ").join("-").downcase
  end

  def self.find_by_slug(string)
    self.find_by(username: string.split("-").join(" "))
  end

end
