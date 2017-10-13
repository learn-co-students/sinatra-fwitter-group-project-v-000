module Slugify

  def slug
    self.username.gsub(/[,:']/, '').gsub(' ', '-').downcase
  end

end
