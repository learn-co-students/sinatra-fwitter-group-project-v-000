class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(sluggedstring)
    @array1 = []
    self.all.find do |inst|
        inst.slug == sluggedstring
    end
  end

end
