class Tweet < ActiveRecord::Base
  include Slugify
  extend ClassSlugify
  belongs_to :user
  validates_presence_of :content
end
