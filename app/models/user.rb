class User < ActiveRecord::Base
  has_many :tweets

  def slug
    user = self.username
    user = user.downcase
    user = user.split(" ")
    user.join("-")
  end
end


def self.find_by_slug(slug)
  self.all.find do |user|
    user.slug == slug
    end

    end
