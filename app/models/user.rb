class User < ActiveRecord::Base
  has_many :tweets
  
  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.class.all.find{|item| item.slug == slug}
  end
end