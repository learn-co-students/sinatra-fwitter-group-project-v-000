class Tweet < ActiveRecord::Base
  belongs_to :user

  include Slugifiable::Instance
  extend Slugifiable::Class

end