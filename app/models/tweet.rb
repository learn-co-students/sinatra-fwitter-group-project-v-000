class Tweet < ActiveRecord::Base
    belongs_to :user 
#   protect the database sothat only the current user logged in may CRUD
  end