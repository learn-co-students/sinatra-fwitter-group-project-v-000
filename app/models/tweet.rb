class Tweet < ActiveRecord::Base
  belongs_to :user

  require_relative 'concerns/slugifiable.rb'

  include Slugifiable

end
