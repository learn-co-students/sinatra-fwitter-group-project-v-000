class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    slug = self.username.downcase
    slug.gsub!(/[^a-zA-Z\d\s-]/, '')
    slug.gsub!(/\s/, '-')
    slug
  end

  def self.find_by_slug(slug)
    self.all.find do |object|
      object.slug == slug
    end
  end

end
