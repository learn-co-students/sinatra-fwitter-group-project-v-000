module Slugifiable

  module ClassMethods

    def find_by_slug(name)
      self.all.detect do |i|
        i.slug == name
      end
    end

  end

  module InstanceMehods
    def slug
      self.username.gsub(" ", "-").downcase
    end
  end



end
