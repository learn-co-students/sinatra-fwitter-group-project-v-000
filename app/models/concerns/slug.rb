module Slug

  module InstanceMethods

    def slug
      self.username.gsub(" ", "-").gsub(/[^\w-]/, '').downcase
    end

  end


  module ClassMethods

    def find_by_slug(value)
      self.all.detect{ |a| a.slug == value}
    end

  end

end
