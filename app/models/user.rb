class User < ActiveRecord::Base
  require_relative 'concerns/slugifiable.rb'
  include Slugifiable

  has_secure_password
  has_many :tweets


  def self.find_by_slug(slug)
    User.all.detect{|obj|obj.slug == slug}
  end

end
