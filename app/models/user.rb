class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :username, presence: true
  validates_uniqueness_of :username
  has_many :tweets
  has_many :likes
  has_many :liked_tweets, :through => :likes, :source => :tweet

  include Slugify::InstanceMethods
  extend Slugify::ClassMethods



end
