class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    a = self.username.downcase
    #binding.pry
    if a.gsub!(/[!@% &"]/,'-')
      slug = a
      #binding.pry
    else
      slug = a
    end
    slug
  end

  def self.find_by_slug(slug)
    value = nil
    User.all.each do |user|
      #binding.pry
      if user.slug == slug
        #binding.pry
        #val = artist
        value = user
      end
    end
    value
  end

end
