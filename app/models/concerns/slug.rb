module Slug
  module ClassMethods
    def find_by_slug(slug)
      username = slug.split("-").map{|word| word}.join("_")
      self.where("LOWER(username) LIKE LOWER(?)", username).first
    end
  end

  module InstanceMethods
    def slug
      self.username.downcase.split(" ").join("-")
    end
  end
end
