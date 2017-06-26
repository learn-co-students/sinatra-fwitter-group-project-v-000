class User < ActiveRecord::Base
      extend Concerns::Slugify_class
      include Concerns::Slugify_instance
      has_many :tweets
      has_secure_password

end

