module Slugger
  module InstanceMethods
    def slug
      self.username.downcase.gsub(" ","-")
    end
  end
  
  module ClassMethods
      
    def self.find_by_slug(slug)
      self.all.find{|x| x.slug == slug}
    end
  end
  
end