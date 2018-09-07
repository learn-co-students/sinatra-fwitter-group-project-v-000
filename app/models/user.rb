class User < ActiveRecord::Base
  has_secure_password

  has_many :tweets

  validates :username, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true

  #could also be handled as separate concerns module (see playlister-sinatra)
  def slug
    slug = self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.each do |val|
      if val.slug == slug
        return val
      end
    end
  end

end
