class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(sluged)
    self.all.find do |n|
    n.slug == sluged
    end
  end
end
