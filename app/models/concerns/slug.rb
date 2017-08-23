module Slug

  module InstanceMethods
    def slug
      self.username.gsub(" ", "-").downcase
     end
    end

  module ClassMethods
    def find_by_slug(username)
      self.all.find {|s| s.slug == username}
  end
 end
end
