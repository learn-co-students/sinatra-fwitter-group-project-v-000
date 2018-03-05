module Slugifiable

  module InstanceMethods
    def slug
      self.username.parameterize if self.username
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.detect{|model| model.slug == slug}
    end
  end

end
