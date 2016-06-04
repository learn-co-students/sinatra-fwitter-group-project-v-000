module Slugifiable

  def self.included(klass)
    klass.extend ClassMethods
  end

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  module ClassMethods
    def self.find_by_slug(slug)
      self.all.find { |song| song.slug == slug }
    end
  end

end
