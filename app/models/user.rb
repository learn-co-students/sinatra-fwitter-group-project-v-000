class User < ActiveRecord::Base
  has_many :tweets

  def slug
    name.downcase.gsub(" ","-")
  end

  def authenticate
  end
end
