class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  #validates_presence_of :password, :on => :create

  def self.find_by_slug(arg)
    self.all.detect {|object| object.slug == arg}
  end

  def slug
    self.username.downcase.split(' ').join('-')
  end

end