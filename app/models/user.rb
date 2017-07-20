class User < ActiveRecord::Base

  has_secure_password
  has_many :tweets

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def self.find_by_slug(slug)
    all.detect { |user| user.slug == slug }
  end

  def slug
    username.downcase.split.join('-')
  end

  def owns?(item)
    item.user_id == self.id
  end

end