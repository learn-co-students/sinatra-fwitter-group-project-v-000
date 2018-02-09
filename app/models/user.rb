<<<<<<< HEAD

class User <ActiveRecord::Base
	has_many :tweets
=======
class User < ActiveRecord::Base
  include Slugified::InstanceMethods
  extend Slugified::ClassMethods
validates_presence_of :username, :email, :password
has_secure_password
has_many :tweets

>>>>>>> af90a5abbf0fb76163fe5effb8517018d1b7a56a
end
