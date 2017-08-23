class UserHelper

  def self.current_user(session)
    User.find(session[:id]) if session[:id]
  end

  def self.logged_in?(session)
    !!current_user(session)
  end

end
