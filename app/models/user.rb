class User < ActiveRecord::Base
has_many :tweets

def slug
  self.downcase.gsub(" ", "-")
end

def self.find_by_slug(slug)
  User.all.find do |user|
    user.slug == slug
  end
end


end
