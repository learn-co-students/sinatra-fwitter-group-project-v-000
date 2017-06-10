class Tweet < Sinatra::Base
  belongs_to :user
  validates :content, presence: true
end
