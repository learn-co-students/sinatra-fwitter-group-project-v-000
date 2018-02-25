class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    self.username.gsub(/[!?,'." "]/, '-').downcase
  end

  def self.find_by_slug(slug_name)
    User.all.detect {|user| user.slug == slug_name}
  end
end
