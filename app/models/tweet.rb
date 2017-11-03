class Tweet < ActiveRecord::Base
	belongs_to :user

	# def slug 
 #    name.downcase.gsub(" ","-")
 #  end

 #  def self.find_by_slug(slug)
 #    Song.all.find{|song| song.slug == slug}
 #  end
	
end