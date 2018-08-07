require 'pry'
class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)

  end



end
