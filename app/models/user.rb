class User < ActiveRecord::Base

  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.all.find do |i|
      i.slug == slug
    end
  end

  has_many :tweets
end
