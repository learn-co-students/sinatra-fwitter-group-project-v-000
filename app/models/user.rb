class User < ActiveRecord::Base
  has_many :tweets

  def slug
    user = self.username
    "#{user.gsub(/\W/, "-").squeeze("-")}".downcase
  end

  def self.find_by_slug(slug)
    @user = User.find_by username: slug.sub("-", " ")
  end

end
