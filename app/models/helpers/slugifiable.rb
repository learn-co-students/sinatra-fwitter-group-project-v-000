module Helpers
  module Slugify
    def slug
      username.parameterize
    end
  end

  module Findable
    def find_by_slug(slug)
      self.all.find{|item| item.slug == slug}
    end
  end
end
