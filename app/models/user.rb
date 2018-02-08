require_relative "../modules/Slug_Mod"
class User < ActiveRecord::Base
  #modules
  include Slug_Mod
  extend Find_By_Slug_Mod

  #relationship
  has_many :tweets

  #instance functions
  def authenticate(test)
    found_user = User.find_by(password: test)
    if !found_user.nil?
      found_user
    else
      false
    end
  end
end
