class User < ActiveRecord:Base
  has_many :tweets

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def seld.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
