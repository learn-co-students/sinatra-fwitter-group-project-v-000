class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.find{|s| s.slug == slug}
  end

  # def authenticate(password)
  #   self.password == password
  # end
end
