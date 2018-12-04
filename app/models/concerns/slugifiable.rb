module Slugifiable
  module InstanceMethods
    def slug
      username.downcase.gsub(" ", "-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{ |username| username.slug == slug }
    end
  end
end
