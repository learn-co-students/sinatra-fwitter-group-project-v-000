class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, uniqueness: true

  def slug
    self.title.strip.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find { |obj| obj.slug == slug }
  end
end
