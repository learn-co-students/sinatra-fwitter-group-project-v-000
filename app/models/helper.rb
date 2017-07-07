class Helper


  def self.logged_in?(session)
    !!session[:user_id]
  end #will return True or False

  def self.current_user(session)
    logged_in?(session) ? User.find(session[:user_id]) : nil
  end

end
