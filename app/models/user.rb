class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def self.find_by_slug(slug)
    all.find { |instance| instance.slug == slug }
  end

  def slug
    username.downcase.strip.tr(' ', '-').gsub(/[^\w-]/, '')
  end
end
