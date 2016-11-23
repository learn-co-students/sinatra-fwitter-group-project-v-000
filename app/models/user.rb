class User < ActiveRecord::Base
  has_secure_password

  has_many :tweets

  def slug
    username.gsub(/\W/,"-")
  end

  def self.find_by_slug(slug)
    User.all.find{|x| x.slug == slug}
  end
end

