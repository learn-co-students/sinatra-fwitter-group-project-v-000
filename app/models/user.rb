# require_relative './concerns/slugs'

class User < ActiveRecord::Base
  include Slug::InstanceSlugs
  extend Slug::ClassSlugs

  has_many :tweets
  has_secure_password

end
