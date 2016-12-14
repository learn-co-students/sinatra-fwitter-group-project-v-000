class User <ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.name.gsub(" ","-").downcase
  end

  def find_by_slug(slug)
    all.each do |x|
      return x if x.slug == slug
    end
  end
  
end
