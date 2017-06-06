module Slugable
	module InstanceMethods
		def slug
			self.username.to_s.downcase.gsub(' ', '-').gsub(/[^\w-]/, '')
		end
	end

	module ClassMethods
		def find_by_slug(slug)
			self.all.detect{|item| item.slug == slug}			
		end
	end
	
end