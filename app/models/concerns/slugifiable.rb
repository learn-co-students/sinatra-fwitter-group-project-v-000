# this is a very very basic slugifier
# it does not handle special characters at all
module Slugifiable
    module ClassMethods
        def find_by_slug (slug)
            self.find_by(username: slug.gsub('-', ' '))
        end
    end 

    def self.included(base)
        base.extend(ClassMethods)
    end

    def slug
        self.username.gsub(' ', '-')
    end
end