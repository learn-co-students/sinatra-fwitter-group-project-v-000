class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.downcase.gsub(/[\s]/, '-')
  end

  def self.find_by_slug(slug)
    User.all.find do |user| #go through all users to find user's slug that matches slug argument
      user.slug == slug
    end
  end
end
