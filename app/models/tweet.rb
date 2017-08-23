class Tweet < ActiveRecord::Base
  include Slug::InstanceMethods
  extend Slug::ClassMethods

  belongs_to :user
  validates :content, presence: true
end
