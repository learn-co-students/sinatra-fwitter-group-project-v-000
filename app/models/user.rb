class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  #Create an **instance** method slug to slugify the username
  #Create a **Class** method to find by slug
  #Hint
end
