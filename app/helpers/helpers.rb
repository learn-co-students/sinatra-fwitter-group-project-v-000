class Helpers
  def current_user(session)
    @user = User.find_by_id(session[:user_id])
  end

  def logged_in?(session)
    !!(session[:user_id])
  end
end
