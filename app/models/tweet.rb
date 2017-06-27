class Tweet < ActiveRecord::Base

  belongs_to :user

  validates :content, :user_id, presence: true

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

end
