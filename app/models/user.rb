require 'bcrypt'

class User < ActiveRecord::Base
  validates_presence_of :username, :password, :email
  has_many :tweets
  #has_secure_password
  include BCrypt

  def slug
  username.downcase.gsub(" ", "-")
end

def self.find_by_slug(slug) #use find
  self.all.find do |song|
    if song.slug == slug
      @song = song
      end
    end
    @song
  end

  def authenticate(password)
    if User.last.password == password
    User.last
  else
    false
  end
  end


end
