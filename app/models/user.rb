require 'sinatra/base'
class User < ActiveRecord::Base

  has_many :tweets
  
  has_secure_password

  def slug
    username = self.username.strip.downcase
      username.gsub! /['`]/,""
      username.gsub! /\s*@\s*/, " at "
      username.gsub! /\s*&\s*/, " and "
      username.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'
      username.gsub! /_+/,"-"
      username.gsub! /\A[_\.]+|[_\.]+\z/,""
      username
  end

  def self.find_by_slug(slug)
      User.all.detect {|user| user.slug == slug}
  end


end
