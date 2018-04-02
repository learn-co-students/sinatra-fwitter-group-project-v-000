class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.downcase.strip.gsub(/\s/, '-')
  end

  def self.find_by_slug(slug)
    self.all.find{|i| i.slug == "#{slug}"}
  end
end
