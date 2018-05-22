class Helpers
  def self.current_user(session)
    user_id = session[:id]
    user = User.find_by(id: user_id)
    user
  end

  def self.logged_in?(session)
    if session.key?(:id)
      true
    else
      false
    end
  end
end
