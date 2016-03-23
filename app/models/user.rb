class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

  def self.current_user(session)
    @user = User.find_by_id(session["user_id"])
    @user
  end

  def self.is_logged_in?(session)
    !!session["user_id"]
  end
end
