class User < ActiveRecord::Base
  include Slugifiable
  has_many :tweets
  has_secure_password
  
  def find_by_slug
    User.all.detect{|i| i.slug == params[:slug]}
  end

end