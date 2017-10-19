class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
  slug = self.username.strip.downcase

  #blow away apostrophes
  slug.gsub! /['`]/,""

  # @ --> at, and & --> and
  slug.gsub! /\s*@\s*/, " at "
  slug.gsub! /\s*&\s*/, " and "

  #replace all non alphanumeric, underscore or periods with hyphen
   slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'

   #convert double hyphens to single
   slug.gsub! /-+/,"-"

   #strip off leading/trailing hyphens
   slug.gsub! /\A[-\.]+|[-\.]+\z/,""

   slug
end

def self.find_by_slug(slug)
  self.all.find do |user|
    user.slug == slug
  end
end

end
