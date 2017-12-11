class User < ActiveRecord::Base
  has_many :tweets
  validates_presence_of :name, :email, :password
  has_secure_password

  attr_accessor :name, :email, :password


    def slug
			self.name.downcase.gsub(" ", "-")
		end

    def self.find_by_slug(slug)
			self.all.find {|thing| thing.slug == slug}
		end


    def has_secure_password
    end

    def is_logged_in?(session)
      !!sessions[:id]
    end

    def current_user(session)
      User.find_by_id(session[:id])
    end
end
