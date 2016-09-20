class User < ActiveRecord::Base 
  has_many :tweets
  has_secure_password

  def slug 
    self.username.gsub(/[" "]/,"-")
  end


  def self.find_by_slug(slug)
    User.all.detect do |target|
      target.slug == slug
    end
  end

end 