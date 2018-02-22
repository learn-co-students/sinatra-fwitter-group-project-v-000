class Tweet < ActiveRecord::Base
  extend Helpifiable

  belongs_to :user
end
