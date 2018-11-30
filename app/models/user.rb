
class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  def self.create_from_form(params)
    User.create(:username => params[:username], :email => params[:email], :password => params[:password])
  end



  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
