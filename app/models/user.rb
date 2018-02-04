class User < ActiveRecord::Base
  has_many :tweets

  def self.current_user(session)
    @user = User.find(session[:user_id])
  end

  def self.is_logged_in?(session)
    !!session[:user_id]
  end

  def slug
    user = self.username
    "#{user.gsub(/\W/, "-").squeeze("-")}".downcase
  end

  def self.find_by_slug(slug)
    @user = User.find_by username: slug.sub("-", " ")
  end

end
