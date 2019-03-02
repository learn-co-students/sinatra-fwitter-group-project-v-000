class User < ActiveRecord::Base
  has_many :tweets
  
# ACTIVERECORD VALIDATIONS - adding more validations into our user model:

# validates is a method invocation
# name is the thing that is beign validated
# presence: true - key value pair
#  these validations will pervent ActiveRecord from:
#  - creation saving updating from the database if these requirements are not meet
  validates :username, presence: true
end
