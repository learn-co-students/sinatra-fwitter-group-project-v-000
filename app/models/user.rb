class User < ActiveRecord::Base
  validates_presence_of :username, :email
  # validates_uniqueness_of :username, presence: {message: "That username is already taken, please use another username"}
  # validates_uniqueness_of :email, presence: {message: "That email is already associated to another account. Please use another email"}

  has_secure_password
  has_many :tweets

  def slug
    self.username.strip.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    name = slug.split("-").map { |word| word.downcase }.join(" ")
    self.all.find { |instance| instance.username.downcase == name }
  end

end