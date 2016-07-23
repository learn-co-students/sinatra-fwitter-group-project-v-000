class User < ActiveRecord::Base
  has_many :tweets

  include Slugifiable::Instance
  extend Slugifiable::Class

end