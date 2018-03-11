module Slugify
	extend ActiveSupport::Concern
	
	included do 
		def slug
			self.username.downcase.split(" ").join("-")
		end

		def self.find_by_slug(slug)
			self.all.detect do |instance|
				instance.slug == slug	
			end
		end
	end
end