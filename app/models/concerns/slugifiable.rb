module Slugifiable
  
  def slug
    self.username.downcase.gsub(' ', '-')
  end
  
  def find_by_slug(s)
    self.all.detect {|user| user.slug == s}
  end
end