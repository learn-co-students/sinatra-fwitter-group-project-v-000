class Tweet < ActiveRecord::Base
  # include Slugable::InstanceMethods
    belongs_to :user

      validates :content, presence: true

end
