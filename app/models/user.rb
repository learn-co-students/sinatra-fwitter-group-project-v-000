class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    new_name = username.downcase
    new_name.gsub(' ', '-')
  end

  def self.find_by_slug(name_slug)
    User.all.find{|a| a.slug == name_slug}
  end
end
