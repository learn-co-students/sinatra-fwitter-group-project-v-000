class Tweet < ActiveRecord::Base
  include Slugifiable::Slugify
  extend Slugifiable::FindableBySlug

  belongs_to :user
  validates_presence_of :content, :user_id
end
