class User < ActiveRecord::Base
  has_many :tweets

  def slug
    binding.pry
    self.username.downcase
  end
end
