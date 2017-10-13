module ClassSlugify
  def find_by_slug(slug)
    the_name = slug.gsub('-', ' ')
    self.all.detect do |object|
      object.username.gsub(/[,:']/, '').downcase == the_name
    end
  end
end
