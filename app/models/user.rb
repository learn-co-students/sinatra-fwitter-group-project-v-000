class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    username.downcase.gsub(/\s+/,'-')
  end

  def self.find_by_slug(slug)
       self.all.detect {|a| a.slug == slug}
  end

end
