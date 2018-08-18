class Tweet < ActiveRecord::Base
    validates :content, presence: true
    validates :user_id, presence: true
    belongs_to :user
    has_many :likes
    has_many :user_likes, :through => :likes, :source => :user
end
