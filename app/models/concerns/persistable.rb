#a dynamic module that contains data that can be re-used, hence the name
module Persistable

  module ClassMethods

    def find_by_slug(slug)
      self.all.find {|subject| subject.slug == slug}
    end

  end

  module InstanceMethods

    def slug
      self.username.downcase.gsub(/\W|( )/, "-")
    end

  end
end
