class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  def slug
    self.username.downcase.gsub(/\s/,'-')
  end
  def self.find_by_slug s
    self.all.detect{ |u| u.slug==s }
  end
end
