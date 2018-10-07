class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slug = self.username.gsub(' ', '-').gsub(/[^\w-]/, '').gsub(/(-){2,}/, '-').downcase
    slug
  end

  def self.find_by_slug(slug)
    self.all.detect{|artist| artist.slug == slug}
  end
end
