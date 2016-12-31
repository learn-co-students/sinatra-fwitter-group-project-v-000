class User < ActiveRecord::Base
  has_many :tweets
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true

  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    User.all.detect(ifnone = "No user found") {|x| x.slug == slug}
  end

  def authenticate(password)
    if self.password == password
      self
    else
      false
    end
  end
end
