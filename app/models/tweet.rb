class Tweet <ActiveRecord::Base
  belongs_to :user

    # validates_presence_of :content

  def slug
    self.name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Tweet.all.find{|tweet| tweet.slug == slug}
  end
end
