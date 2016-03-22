class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.all.find{ |find| find.slug == slug}
  end

end
