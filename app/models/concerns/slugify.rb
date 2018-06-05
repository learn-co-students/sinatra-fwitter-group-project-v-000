module Slugifiable

  def slug
    self.username.gsub(" ", "-").downcase
  end

end


module Findable

  def find_by_slug(slug)
    self.all.find do |instance|
      instance.slug == slug
    end
  end
end
