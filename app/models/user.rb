class User < ActiveRecord::Base
  has_many :tweets

  has_secure_password

  validates :username, :presence => true,
                       :uniqueness => true
  validates :email,    :presence => true,
                       :uniqueness => true
  validates :password, :presence => true

  def slug
    x = self.username.downcase.split(' ')
    x.join('-')
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end

  def self.authenticate(params)
    @user = User.find_by_name(params[:username])
    (@user && @user.password == params[:password]) ? @user : nil
  end

end
