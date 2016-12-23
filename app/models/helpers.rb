class Helpers

  def self.current_user(session_params)
    User.find(session_params[:id])
  end

  def self.is_logged_in?(session_params)
    session_params[:id] != nil
  end

end
