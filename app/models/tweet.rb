class Tweet < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :content

  def slug
    name.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Tweet.all.find{|user| user.slug == slug}
  end
end
