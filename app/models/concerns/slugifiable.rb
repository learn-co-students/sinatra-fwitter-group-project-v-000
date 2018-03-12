module Slugifiable
  module InstanceMethods
    def slug
      if self.methods.include?(:username)
        str = self.username
      else
        str = self.content
      end
      str = str.downcase
      return str.gsub " ", "-"
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.detect{|inst|
        slug == inst.slug
      }
    end
  end
end
