class Tweet < ActiveRecord::Base
  has_secure_password
  belongs_to :user
end
