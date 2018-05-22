class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :username, :presence => true
  validates :email, :presence => true

  def slug
    name = self.username.downcase
    name_array = name.split(" ")
    name_array.join("-")
  end

  def self.find_by_slug(slug)
    slug_array = slug.split("-")
    name_joined = slug_array.join(" ")
    self.all.each do |user|
      if user.username.casecmp(name_joined) == 0
        return user
      end
    end
  end
end
