class User < ActiveRecord::Base 
  has_many :tweets


  def slug 
    self.username.downcase
  end


  def self.find_by_slug(slug)
    User.all.detect do |target|
      target.slug == slug
    end
  end

end 