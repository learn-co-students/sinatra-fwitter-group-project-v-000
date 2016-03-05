module Slug
  module InstanceSlugs

    def slug
      self.username.downcase.gsub(' ', '-')
    end
  end

  module ClassSlugs

    def find_by_slug(text)
      self.find{|w| w.slug == text}
    end
  end
end
