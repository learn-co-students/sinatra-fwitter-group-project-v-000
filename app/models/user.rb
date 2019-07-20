class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true
  has_secure_password
  has_many :tweets

  def self.find_by_username(username)
    self.all.select do |user|
      user.username == username
    end
  end

end
