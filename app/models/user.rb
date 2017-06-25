class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, :email, :password_digest, presence: true

  def slug
    self.username.gsub(/\ |[$.+'()&]/, '-').downcase
  end

  def self.find_by_slug(slug)
    self.all.detect do |i|
      i.slug == slug
    end
  end
end
