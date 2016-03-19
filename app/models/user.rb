class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def slug
      self.username.downcase.gsub(" ", "-")
    end

    def self.find_by_slug(slug)
      User.all.find{|user| user.slug == slug}
    end


end