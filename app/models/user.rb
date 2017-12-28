class User<ActiveRecord::Base
  has_secure_password
  has_many :tweets

    def slug
      puts self.username
      slug=self.username.downcase.gsub(" ", "-")
    end


  def self.find_by_slug(slug)
    username=slug.split("-").join(" ")
    #puts name
    #binding.pry
    return find_by(username).first
  end




end
