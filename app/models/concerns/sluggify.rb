module Sluggify
  module InstanceMethods
    def slug
      self.username.gsub(' ','-').downcase unless self.username.nil?
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      self.all.find {|x| x.slug == slug}
    end
  end
end
