class Tweet < ActiveRecord::Base
  belongs_to :user

  def slug
    self.content.downcase.gsub(' ','-')
  end

  def self.find_by_slug(slug)
    Tweet.all.detect do |tweet|
      slug == tweet.slug
    end
  end

end
