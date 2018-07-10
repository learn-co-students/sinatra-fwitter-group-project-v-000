
class Slugify 
  
      
    def slug
      self.name.gsub(" ", "-").gsub(/[^\w-]/, '').downcase
    end


    def find_by_slug(value)
      self.all.detect{ |a| a.slug == value}
    end
    
end