class Tweet < ActiveRecord::Base
  belongs_to :user

  extend Slug::ClassMethods
  include Slug::InstanceMethods
end
