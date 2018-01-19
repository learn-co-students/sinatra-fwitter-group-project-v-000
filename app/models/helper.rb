class Helper < ActiveRecord::Base

def self.current_user(session)
  @user = User.find_by(session[:id])
end

def self.logged_in?(session)
  !!session[:user_id]
end
end
