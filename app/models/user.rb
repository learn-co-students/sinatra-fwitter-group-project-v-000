class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  
  # extend Slug::ClassMethods
  # include Slug::InstanceMethods

  
  def slug
    self.username.gsub(" ", "-").gsub(/[^\w-]/, '').downcase
  end


  def self.find_by_slug(value)
    self.all.detect{ |a| a.slug == value}
  end
  
end
