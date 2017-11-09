module Slugifiable

  module InstanceMethods
    def slug
      self.username.split(' ').join('-')
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      username = slug.gsub('-',' ')
      all.find_by(username: username)
    end
  end

end
