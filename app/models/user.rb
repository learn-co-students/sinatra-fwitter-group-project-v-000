class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def self.find_by_slug(slug)
    split_slug = slug.split("-")
    # binding.pry
    self.find_by(username: split_slug.join(" "))
  end

  def slug
    split_name = self.username.split(" ")
    slugged = split_name.join("-")
  end
end
