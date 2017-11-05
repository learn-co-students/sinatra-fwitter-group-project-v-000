class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  # def slug
  #   self.name.downcase.split(" ").join("-")
  # end
  
  # def self.find_by_slug(slug)
  #   match = ""

  #   self.all.each do |user|
  #     if user.slug == slug
  #       match = user
  #     end
  #   end
  #   match
  # end

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end