module Slugifiable

	module InstanceMethods	
		def slug
			self.username.downcase.gsub(" ", "-")
		end
	end
	
	module ClassMethods
	  def find_by_slug(slug)
			name = slug.gsub("-", " ")	
			self.all.find {|obj| obj.username == name}
		end
	end

end
