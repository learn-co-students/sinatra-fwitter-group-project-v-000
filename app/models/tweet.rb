require "sinatra/base"
class Tweet < ActiveRecord::Base
  belongs_to :user

end
