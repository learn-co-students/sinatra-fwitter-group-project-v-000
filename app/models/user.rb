class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.name.downcase.gsub(" ","-").gsub(/[^a-zA-Z0-9-]/, "")
  end

  def find_by_slug(search_slug)
    self.all.detect{|i| i.slug == search_slug}
  end

end
