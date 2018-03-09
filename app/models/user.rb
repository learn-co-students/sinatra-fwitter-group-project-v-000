require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :tweets
  has_secure_password

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug_name)
    self.all.find do |obj|
      obj.slug == slug_name
    end
  end
end
