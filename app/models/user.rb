class User < ActiveRecord::Base
    validates :name, presence: true
    validates :username, presence: true
    has_many :tweets
    has_many :likes
    has_many :liked_tweets, :through => :likes, :source => :tweet
end