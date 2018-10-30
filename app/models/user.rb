class User < ActiveRecord::Base
  #username, email, password
  has_many :tweets
  has_secure_password

  def slug
    x = self.username.downcase.split(' ')
    x.join('-')
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end

end
