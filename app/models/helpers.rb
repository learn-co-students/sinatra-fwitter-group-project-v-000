class Helpers
  def self.current_user(session)
      User.find(session[:id])
  end

  def self.logged_in?(session)
    !!session[:id]
  end
end
