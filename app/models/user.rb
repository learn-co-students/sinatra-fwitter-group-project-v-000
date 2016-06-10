class User < ActiveRecord::Base
  has_many :tweets

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

  def authenticate(password)
    if password == self.password
      self
    else
      false
    end
  end
end