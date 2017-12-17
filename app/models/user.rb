class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  require_relative 'concerns/slugifiable.rb'

  include Slugifiable

end
