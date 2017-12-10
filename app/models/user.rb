class User < ActiveRecord::Base
  has_many :tweets

  def slugify
  end

  def find_by_slug
  end

  def has_secure_password
  end
end
