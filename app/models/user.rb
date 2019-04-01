class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of  :username, :email, :password_digest


  def slug
      self.username.downcase.split(' ').join('-')
  end

  def self.find_by_slug(slug)
      @all_user_info = []
      self.all.each do |user|
          if user.slug == slug
              @all_user_info << user
          end
      end
      @all_user_info[0]
  end
end
