class User < ActiveRecord::Base
    has_many :tweets
    has_secure_password
    validates :username, presence: true
    validates :email, presence: true
    validates :password, presence: true

  def slug
    self.username.squish.downcase.tr(" ","-")
  end

  def self.find_by_slug(slug)
    found = nil
   User.all.each do |user|
        found = user if user.slug == slug
    end
    found
  end #find_by_slug
end