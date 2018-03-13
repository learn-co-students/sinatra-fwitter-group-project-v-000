class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def find_by_slug(slug)
    self.all.detect{|user|user.slug == slug}
  end


  def slug
    name.downcase.gsub(" ","-")
  end


  end
