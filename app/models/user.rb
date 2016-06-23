class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    Slugifiable.slugify(self.username)
  end

  def self.find_by_slug(nameslug)
    self.all.detect { |i| i.slug == nameslug}
  end
end