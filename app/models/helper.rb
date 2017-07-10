class Helper
  def self.logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    self.logged_in?(session) ? User.find_by_id(session[:user_id]) : nil
  end

end
