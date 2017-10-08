class User < ActiveRecord::Base
    has_many :tweets
  
    has_secure_password
  
    def slug
      username.downcase.gsub(" ","-").gsub(/([\.\,\@\!\?\&\#\$\%\*\"\'\`\:\/\=\+\(\)\/])/,"")
    end

    def self.find_by_slug(sluggified)
      self.all.find {|instance| instance.slug == sluggified}
    end

  end