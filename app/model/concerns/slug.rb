module Slugifiable
  module InstanceMethods
    def slug
      self.username.gsub(/\s/, "-").downcase
    end
  end
   module ClassMethods
      def find_by_slug(slug)
        unslug = slug.gsub(/-/, " ")
        self.find_by(username: unslug)
      end
    end
end