class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  require_relative 'concerns/slugifiable.rb'

  include Slugifiable

  def self.find_by_slug(slug)
    User.all.detect{|obj|obj.slug == slug}
  end

end
