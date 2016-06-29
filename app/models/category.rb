class Category < ActiveRecord::Base

  has_many :posts

  def slug
    self.name.gsub(/\s/, "-").downcase
  end

  def self.find_by_slug(slug)
    Category.all.find{|category| category.slug == slug}
  end
end
