class User < ActiveRecord::Base
  has_many :tweets

  def self.slug
    user = self.name
    binding.pry
  end
end
