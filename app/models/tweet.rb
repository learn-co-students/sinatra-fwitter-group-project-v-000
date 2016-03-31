class Tweet < ActiveRecord::Base
  belongs_to :user
  include Slugifiable::Instance
  extend Slugifiable::Class
  validates_presence_of :content
end
