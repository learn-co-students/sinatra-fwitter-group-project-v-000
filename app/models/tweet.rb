class Tweet < ActiveRecord::Base
  # add relationships here
    #Tweets should have content and belong to a user.
  belongs_to :user

end
