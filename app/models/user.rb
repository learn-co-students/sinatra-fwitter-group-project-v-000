class User < ActiveRecord::Base
  include Slugable::InstanceMethods

  validates_presence_of :username, :email, :password
  has_secure_password

  # make sure that our user fill_in those pieces... email, password etc.
  has_many :tweets

  def self.find_by_slug(slug)
        self.all.find do |instance|
         instance.slug == slug
    end
   end

end
