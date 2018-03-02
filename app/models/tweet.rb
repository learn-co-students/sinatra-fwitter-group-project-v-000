class Tweet < ActiveRecord::Base
  extend Slugifiable::FindableBySlug

  belongs_to :user
  validates_presence_of :content, :user_id

  def slug
    self.content.downcase.gsub(/ /, "-")
  end
end
