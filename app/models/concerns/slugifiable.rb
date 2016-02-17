module Slugifiable 
  def slug
    self.username.slugify
  end

  def self.included(base)
    base.extend(ClassMethods)
  end


  module ClassMethods
    def find_by_slug(slugged)
      self.all.select do |obj|
         obj.slug == slugged 
      end.first
    end
  end

end