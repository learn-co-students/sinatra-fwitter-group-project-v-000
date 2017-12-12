class User < ActiveRecord::Base
  has_many :tweets

  require_relative 'concerns/slugifiable.rb'

  include Slugifiable

end
