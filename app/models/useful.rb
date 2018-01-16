module Useful
  module InstanceMethods
    def slug
      self.name.downcase.split(" ").join("-")
    end
  end

  module ClassMethods
    def find_by_slug(object)
      self.all.find {|item| item.slug == object}
    end
  end

end
