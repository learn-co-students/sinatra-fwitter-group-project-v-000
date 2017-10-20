class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :presence => true
  validates_presence_of :email, :presence => true
  validates_presence_of :password, :presence => true

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    self.all.detect {|i| puts i.slug; i.slug == slug}
  end

end
