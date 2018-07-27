
class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true # :format => {:with => /\w+@\w+\.\w+/)
  validates :password, :presence => true

  def self.find_by_slug(slug)
    User.all.detect { |user| user.slug == slug }
  end

  def slug
    self.username.downcase.strip.gsub(/\p{P}/, '').gsub(/\W+/, '-')
  end

end