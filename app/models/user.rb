class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_many :tweets

  def slug
    self.username.downcase.split(" ").join("-")
  end
end
