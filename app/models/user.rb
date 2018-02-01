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
    Artist.all.select do |artist|
      artist.slug == slug
    end[0]
  end

end
