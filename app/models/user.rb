require_relative "./concerns/slugifiable.rb"


class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true
  validates :email, presence: true

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end
