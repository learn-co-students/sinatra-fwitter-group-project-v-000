class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :password_digest, :email

  def slug
    self.username.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    name_array = slug.split("-")
    self.all.find do |users|
      clean_name = users.username.downcase.gsub('-', " ")
      clean_name.split(" ") == name_array
    end
  end
end
