class User < ActiveRecord::Base
  has_many :tweets
  
  def slug
    self.username.downcase.gsub(" ", "-")
  end
  
  def self.find_by_slug(slug_to_find)
    self.all.find{|u| u.slug == slug_to_find}
  end
  
  def authenticate(entered_password)
    if entered_password == self.password
      self
    else
      false
    end
  end
end
