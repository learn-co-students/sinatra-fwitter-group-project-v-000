class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :password, :email
  has_many :tweets

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    self.all.each do |user|
      if user.slug == slug
        return user
      end
    end
  end

end
