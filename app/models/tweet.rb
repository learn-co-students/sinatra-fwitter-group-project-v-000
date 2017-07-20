class Tweet < ActiveRecord::Base
    belongs_to :user

     def slug
        self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
    def self.find_by_slug(slug)
        Tweet.all.find{|tweet| tweet.slug == tweet}
    
    end
end 