class Tweet < ActiveRecord::Base
  extend Helpers

  belongs_to :user
end
