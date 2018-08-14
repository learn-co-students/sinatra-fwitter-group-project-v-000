# We might consider renaming this module -
# it's hard to tell from the name what it does
module Slugifiable
  module InstanceMethods
    def slug
      self.username.downcase.gsub(/ /,'-')
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find do |x|
        x.slug == slug
      end
    end
  end

end
