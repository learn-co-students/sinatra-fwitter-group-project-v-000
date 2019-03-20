class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.downcase.split.collect { |word|
      word.gsub(/\W/, "")
    }.join("-")
  end

  def self.find_by_slug(slug)
      self.all.select { |instance|
      instance.slug == slug
    }.first
  end

end
