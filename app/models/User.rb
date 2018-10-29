class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :password, :email

  def slug
    self.username.downcase.tr(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.each do |user|
      if user.slug == slug
        return user
      end
    end
  end
end
