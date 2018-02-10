class User < ActiveRecord::Base
  validates :username, presence: true
  validates :email, presence: true
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.gsub(" ","-").gsub(/[^a-zA-Z0-9-]/, "")
  end

  def self.find_by_slug(search_slug)
    self.all.detect{|i| i.slug == search_slug}
  end

end
