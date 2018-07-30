class User < ActiveRecord::Base
  # has_secure_passord is a macro working in conjunction with bcript gem that secures passwords.
  # Access password_digest in database through pasword attribute. has_secure_password makes this conversion automatically.
  has_secure_password

  has_many :tweets

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
