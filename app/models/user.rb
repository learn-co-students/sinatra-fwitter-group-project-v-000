class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.split(/[^\w]/).map{|x| x.downcase}.join("-")
  end

  def self.find_by_slug(slug)
    self.all.find {|x| x.slug == slug}
  end
end