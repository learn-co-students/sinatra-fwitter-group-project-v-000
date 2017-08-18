class Users < ActiveRecord::Base
  has_many :tweets
end
