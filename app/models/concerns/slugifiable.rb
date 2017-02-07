module Concerns
  module InstanceMethods # include
    def slug
      #self.name.gsub(" ", "-").downcase
      if self.username == nil
        self.username = "No username"
      elsif self.username.match(/\s/) == nil 
        self.username.downcase 
      else
        self.username.gsub(/[^a-z\sA-Z1-9]/, '').split.join('-').downcase
      end
    end
  end

  module ClassMethods # extend
    def find_by_slug(slug)
      self.all.find { |i| i.slug == slug}
    end
  end
end

# include Concerns::InstanceMethods
# extend Concerns::ClassMethods

