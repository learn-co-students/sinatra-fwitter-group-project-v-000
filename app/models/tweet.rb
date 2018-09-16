require_relative './concerns/slugifiable'

class Tweet < ActiveRecord::Base
  belongs_to :user
end
