class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

    def slug
    self.username.split.collect do |word|
      #binding.pry
      word.downcase.gsub(/\W/,"")
    end.join("-")
  end

  def self.find_by_slug(slug)
    User.all.select do |user|
      user.slug == slug
    end[0]
  end

end
