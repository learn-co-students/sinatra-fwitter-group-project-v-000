class Tweet < ActiveRecord::Base
  belongs_to :owner

  def slug
    username.downcase.gsub(' ', '-')
  end

  def find_by_slug(slug)
    Tweet.all.find{ |tweet| tweet.slug == slug }
  end
end
