class Tweet < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true

  extend Parser::ClassMethods
  include Parser::InstanceMethods
end
