module Slugifiable


  module ClassMethods
    def find_by_slug(slug)
     self.all.detect do |name|
       name.slug == slug
     end
    end
  end


  module InstanceMethods
    def slug
      username.strip.downcase.gsub(" ", "-").gsub(/[^\w-]/,"")
    end
  end



end
