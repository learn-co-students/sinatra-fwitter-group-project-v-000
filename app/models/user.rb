class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slug_name = self.username.gsub(/[^a-zA-Z0-9]/,'-').downcase
  end

  def self.find_by_slug(slug)
    User.all.find {|a| a.slug === slug}
  end

end
