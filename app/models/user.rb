class User < ActiveRecord::Base
   has_many :tweets
   has_secure_password
   
   include Slugifiable
   extend Slugifiable
 end