module Slugs
  module ClassMethods
    def find_by_slug(slug)
      self.all.find { |instance| instance.slug == slug }
    end
  end

  module InstanceMethods
    def slug
      self.username.gsub(/\s/,'-').downcase
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end