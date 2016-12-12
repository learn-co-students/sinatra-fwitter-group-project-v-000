class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def self.find_by_slug(slug)
    self.all.find {|object| object.slug == slug}
  end

  def slug
    slug_name = self.username.downcase.scan(/[a-z0-9]*/).reject! {|i| i.empty?}
    slug_name.join("-")
  end

end
