class User < ActiveRecord::Base

  has_secure_password

  has_many :tweets

  def slug
    self.username.sub(" ","-")
  end

  def self.find_by_slug(slug)
    user = []
    User.all.each do |u|
      if slug == u.slug
        user = u
      end
    end
    user
  end



end