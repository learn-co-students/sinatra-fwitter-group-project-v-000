class Usertweet < ActiveRecord::Base
    belongs_to :user
    belongs_to :tweet


end