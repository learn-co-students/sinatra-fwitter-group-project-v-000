class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    if self.username.include?(' ')
      camel_slug = self.username.gsub " ", "-"
      camel_slug.downcase
    else
      self.username.downcase
    end
  end

  def self.find_by_slug(slug)
    if slug.include?('-')
      name = slug.gsub "-", " "
      matching_user = User.find{ |user| user.username.downcase == name }
    else
      matching_user = User.find{ |user| user.username.downcase == slug }
    end
  end
end
