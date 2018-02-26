class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  
  def slug
    username.gsub(/[^\s\w]/, '').gsub(/\s{1,}/, '-').downcase
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

  # def self.valid_username(uname)
  #   User.all.find{|u| u.username == uname}
  # end
end
