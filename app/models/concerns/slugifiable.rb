module Slugifiable
	module InstanceMethods
		def slug
			self.username.downcase.gsub(' ','-')
		end
	end

	module ClassMethods
		def find_by_slug(slug)
			# binding.pry
			self.all.detect{|x| slug == x.slug}
		end
	end
end