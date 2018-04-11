class User < ActiveRecord::Base
    has_many :tweets   
    has_secure_password

    def slug
        #"Hotline Bling" => hotline-bling
        username.downcase.split(/\s*\W/).join("-")
      end
      
      def self.find_by_slug(slug)
        #binding.pry
        User.all.find {|username| username.slug == slug}
      end
    

end