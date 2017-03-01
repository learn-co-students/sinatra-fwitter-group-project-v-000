module Slugifiable
  module InstanceMethods
    def slug
      slug = self.username.downcase.strip.gsub(' ', '-')
      slug
    end

  end

  module ClassMethods

    def find_by_slug(slug)
      artist = self.all.detect {|s| s.slug == slug}
      artist
    end

  end

end
