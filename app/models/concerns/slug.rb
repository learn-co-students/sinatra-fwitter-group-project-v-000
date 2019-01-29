module Slug
	module ClassMethods
		def find_by_slug(slug)
			self.all.select {|obj| obj.slug == slug}[0]
		end
	end

	module InstanceMethods
		def slug
			self.username.downcase.gsub(' ', '-')
		end 
	end
end