class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.split(" ").join("-").downcase
  end

  def self.find_by_slug(word)
    User.all.find{|user| user.slug == word}
  end

end