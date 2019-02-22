class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    #strip string and downcase
    slug = self.username.downcase.strip

    #get rid of apostrophes
    slug.gsub! /['`]/,""

    #@ --> at, and & --> and
    slug.gsub! /\s*@\s*/, " at "
    slug.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
     slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'

     #convert double underscores to single
     slug.gsub! /_+/,"-"

     #strip off leading/trailing underscore
     slug.gsub! /\A[_\.]+|[_\.]+\z/,""

     slug
  end

  def self.find_by_slug(slug)
    found = User.all.find {|s| s.slug == slug}
    found
  end

end
