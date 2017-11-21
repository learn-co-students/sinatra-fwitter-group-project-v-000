class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

  end

  def self.find_by_slug(string)
    self.all.find {|user| user.slug == string}
  end
end
