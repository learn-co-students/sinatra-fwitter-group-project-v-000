class Tweet < ActiveRecord::Base
  include Helpers::Slugify

  belongs_to :user
end
