class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.split(' ').join('-').downcase
  end

  class << self
    def find_by_slug(slug)
      self.all.find {|user| user.slug == slug}
    end
  end
end
