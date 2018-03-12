class Tweet < ActiveRecord::Base
  include Concerns::Slugify
  extend Concerns::Findable
  belongs_to :user
end
