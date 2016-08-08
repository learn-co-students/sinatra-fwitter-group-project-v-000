class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.downcase.gsub(/[' ']/, '-')
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

  def authenticate(password)
    if self.password == password
      self
    else
      return false
    end
  end
end
