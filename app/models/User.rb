class User < ActiveRecord::Base
has_secure_password
has_many :tweets

def slug
temp = self.username
temp1 = temp.parameterize
temp1
end

def self.find_by_slug(slug)
self.find{|user| user.slug == slug}
end

end
