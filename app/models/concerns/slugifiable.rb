module Slugifiable

     def slug
        self.username.gsub(/\W/,"-").downcase
     end
 end
 
