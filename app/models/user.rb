class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, :presence => true
  validates :email, :presence => true

  def slug
    name = self.username.downcase
  end

  def self.find_by_slug(slug)
    self.all.each do |user|
      if user.username.casecmp(slug) == 0
        return user
      end
    end
  end
end
