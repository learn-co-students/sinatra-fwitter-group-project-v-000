module Slugifiable
     def slug
       self.name.gsub(/\W/,"-").downcase
     end
 end
