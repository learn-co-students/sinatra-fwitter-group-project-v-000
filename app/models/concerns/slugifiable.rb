module Slugifiable
  module InstanceMethods
    def slug
      username = self.username.strip.downcase
      username.gsub! /['`]/,""
      username.gsub! /\s*@\s*/, " at "
      username.gsub! /\s*&\s*/, " and "
      username.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'
      username.gsub! /_+/,"-"
      username.gsub! /\A[_\.]+|[_\.]+\z/,""
      username
    end
  end

  module ClassMethods
    def find_by_slug(arg)
      self.all.detect do |x|
        x.slug == arg
      end
    end
  end
end
