class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug 
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slugged_name)
    self.all.detect do |username|
      username.slug == slugged_name
    end
  end

end