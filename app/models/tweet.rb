class Tweet < ActiveRecord::Base
  belongs_to :user
  # validates :content, presence: true
  validates_presence_of :content
end
