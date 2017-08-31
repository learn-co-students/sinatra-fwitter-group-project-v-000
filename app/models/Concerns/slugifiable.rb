module Concerns::Slugifiable
   module ClassMethods

     def find_by_slug(slug)
       name = slug.gsub('-',' ').strip
       self.find_by(username: name)
     end
   end

   module InstanceMethods

     def slug
       self.username.gsub(' ','-').downcase.strip
     end
   end

 end
