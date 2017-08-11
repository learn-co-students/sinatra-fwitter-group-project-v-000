class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :username, :email, :password
  has_secure_password

  def slug
    username.downcase.gsub(" ", "-") unless username.nil?
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      user.slug == slug
    end
  end

end
