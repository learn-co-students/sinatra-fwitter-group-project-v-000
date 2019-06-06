class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

    def slug
      self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(slug)
      instance = nil
      self.all.each do |i|
        if i.slug == slug
          instance = i
        end
      end
      instance
    end
end
