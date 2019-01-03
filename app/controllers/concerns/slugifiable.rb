module Slugifiable

  module InstanceMethods
    def slug
      username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find {|item| item.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') == slug }
    end
  end
end
