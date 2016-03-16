class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :content, length: {in: 1..140}
end
