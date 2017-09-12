class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :email, :presence => true
  validates :username, :presence => true
  # validations make sure that these fields aren't empty when the record is saved

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    self.all.find{|x| x.slug == slug}
  end
end
