class User < ActiveRecord::Base

   extend Concerns::Slugifiable::ClassMethods
   include Concerns::Slugifiable::InstanceMethods

   has_many :tweets

   validates_presence_of :username, :email, :password

   def authenticate(password)
     password == self.password ? self : false
   end

 end
    
