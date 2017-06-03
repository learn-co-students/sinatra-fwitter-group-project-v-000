class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|inst| inst.slug == slug}
  end

  def authenticate(pw_attempt)
    pw_attempt == self.password ? self : false
  end
end
