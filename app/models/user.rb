class User < ActiveRecord::Base
  # extend Helpifiable

  validates_presence_of :username, :email, :password

  has_many :tweets
  has_secure_password

  def slug
    self.username.split(" ").map do |word|
      word.downcase
    end.join("-")
  end

  def self.find_by_slug(slug)
    unslug_name = slug.split("-").join(" ")
    User.where("LOWER(username) = ?", "#{unslug_name}").first
  end
end
