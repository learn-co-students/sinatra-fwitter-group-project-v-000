module Slugify

  module InstanceMethods

    def slug
      self.username.gsub(/\s+/, "-").downcase
    end

  end


  module ClassMethods

    def find_by_slug(slug)
      self.find_by(username: (slug.gsub(/-/, " ")))
    end

  end


end