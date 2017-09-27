class User < ActiveRecord::Base

  has_many :tweets

  def slug
    name = self.username.downcase
    split = name.split(" ")
    new_name = split.join("-")
    return new_name
  end

  def self.find_by_slug(slug)
    self.all.each do |user|
      if user.slug == slug
        return user
      end
    end
  end

  def authenticate(password)
    if self.password == password
      return self
    else
      return false
    end
  end

end
