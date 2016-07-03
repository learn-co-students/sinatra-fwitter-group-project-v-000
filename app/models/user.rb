class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :on => :create
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create

    def slug
      self.username.downcase.gsub(/[^a-z0-9]+/, '-').chomp('-')
    end


    def User.find_by_slug(slug)#if slug is joe-blow
      @count = 0
      if slug.include?("-")
        @new_slug = slug.split("-")#creates "joe blow"
      else
        @new_slug = Array.new
        @new_slug << slug #creates "bob"
      end
      User.all.each do |user|
        @username = user.username
        @new_slug.each do |word| #for multi or single line (single is in array)
          if @username.include?(word) || @username.include?(word.capitalize)
            @count += 1
            if @count == @new_slug.length
              @match = user
            end
          end
        end
      end
    @match #returns user object matching slug
    end
  

end