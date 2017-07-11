class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    strip_chars_array = self.username.downcase.scan(/[a-z0-9]+/)
    slug = strip_chars_array.join("-")
  end

  def self.find_by_slug(slugged)
    found = []
    self.all.each do |obj|
      if slugged == obj.slug
        found << obj
      end
    end
    found[0]
  end
end
