class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates_presence_of  :username, :email, :password_digest

  def slug
    name = self.username.downcase
    split_name = name.split(" ")
    slug_name = split_name.join("-")
    slug_name
  end
  
  def self.find_by_slug(slug)
    split_slug = slug.split("-")
    deslugified_name = split_slug.each_with_index.map{|word| word}.join(" ")
    self.find_by(username: deslugified_name)
  end

  def logged_in?
    !current_user.nil?
   end

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

end