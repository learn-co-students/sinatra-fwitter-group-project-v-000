class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def slug
    self.username.gsub(" ","-" ).downcase
  end

  def find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
    end
  end
