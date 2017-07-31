class User < ActiveRecord::Base

  has_secure_password
  has_many :tweets
  validates :username, :email, presence: true

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slugged)
    User.all.find{|user| user.slug == slugged}
  end
end
