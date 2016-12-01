module Slugifiable
   def slug
     self.username.gsub(/[^0-9A-Za-z" "]/, '').downcase.split(" ").join("-")
   end
 
   def find_by_slug(slug)
     @all = self.all
     @all.detect {|object| object.slug == slug}
   end
 end