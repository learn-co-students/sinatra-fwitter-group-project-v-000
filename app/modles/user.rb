class User < ActiveRecord::Base
  has_many :tweets

  def slug
    self.split()
  end

  def find_by_slug(slug)

  end
end
