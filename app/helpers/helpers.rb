class Helpers
  def self.current_user(session)
    User.find(session[:id])
  end

  def self.is_logged_in?(session)
    !session.empty?
  end
end
