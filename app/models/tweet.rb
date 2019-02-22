class Tweet < ActiveRecord::Base
  include Slugifiable
  belongs_to :user
end