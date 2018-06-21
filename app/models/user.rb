class User < ActiveRecord::Base

  attr_writer :slug

  has_secure_password

  has_many :tweets

  validates :username, :email, :password, presence: true

  def slug
    @slug = self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug_name)
    self.all.each do |user|
      if user.slug = slug_name
        return user
      end
    end
  end

end
