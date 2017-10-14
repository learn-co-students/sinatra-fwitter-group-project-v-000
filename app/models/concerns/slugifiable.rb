module Slugifiable

  module ClassMethods

    def find_by_slug(input)
      unslugged_input = input.split("-").join(" ")

      output ||= User.where('username like ?', unslugged_input).first
    end
  end

  module InstanceMethods

    def slug
      slugified_name = self.username.split.map {|w| w.downcase}.join('-')
    end
  end
end
