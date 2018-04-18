class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    #binding.pry
    self.username.gsub(" ","-").downcase
  end

  def self.find_by_slug(artist_slug)
    User.all.detect{|song| song.slug == artist_slug}
  end
end
