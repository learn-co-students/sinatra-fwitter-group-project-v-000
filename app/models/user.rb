class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def find_by_slug(slug)
    self.all.detect do |v|
      v.slug == slug
    end
  end
end
