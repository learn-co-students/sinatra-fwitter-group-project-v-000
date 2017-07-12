class User < ActiveRecord::Base

  validates_presence_of :username, :email
  
  has_many :tweets

  has_secure_password

  def slug
    self.username.strip.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    name = slug.split("-").map { |word| word.downcase }.join(" ")
    self.all.find { |instance| instance.username.downcase == name }
  end

end
