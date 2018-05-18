class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    self.username.downcase.split.join("-")
  end

  def self.find_by_slug(slug)
    User.all.detect{|users| users.slug == slug}
  end

  def add_tweet(tweet)
    self.tweets << tweet
    tweet.user_id = self.id
    tweet.save
    self.save
  end

end
