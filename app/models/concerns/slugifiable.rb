module Slugifiable
	module InstanceMethods

		def slug
			self.username.gsub(" ", "-").downcase
		end

		
	end
end