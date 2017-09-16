class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def self.current_user(session)
    self.find(session[:id])
  end

  def self.is_logged_in?(session)
    !!session[:id]
  end

  def self.find_by_slug(slug)
    self.all.find{|object| object.slug == slug}
  end

  def slug
    self.username.downcase.gsub(" ", "-")
  end

end