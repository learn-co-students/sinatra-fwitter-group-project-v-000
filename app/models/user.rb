class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")

  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

  def self.find_name_by_id(id)
    user = User.all.find{|user| user.id == id}
    user.username
  end

end
