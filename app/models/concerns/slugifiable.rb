module Slugifiable

  # Class Method (extend)
  module FindableBySlug
    def find_by_slug(slug)
      self.all.find do |object|
        object.slug == slug
      end
    end
  end

end
