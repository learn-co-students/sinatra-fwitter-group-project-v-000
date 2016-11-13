class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    match = ""
    User.all.each do |user|
      if user.slug == slug
        match = user
      end
    end
    match
  end
end
