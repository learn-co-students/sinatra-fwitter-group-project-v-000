class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    username.gsub(' ','-').downcase
    # @slug = slugger.gsub(/^[-]\W/,'')
    # self.slug = @slug
    # @slug

  end

  def self.find_by_slug(slug)
    self.all.find do |s|
      s.slug == slug
    end
  end

end
