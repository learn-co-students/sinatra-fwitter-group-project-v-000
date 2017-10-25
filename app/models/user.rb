class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.split(" ").each do |t|
      t.downcase
    end.join("-")
  end

  def self.find_by_slug(slug)
    User.all.find do |t|
      t.slug == slug
    end
  end
end 