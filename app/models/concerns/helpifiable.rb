module Helpifiable
  def current_user(session)
    user = User.find_by(id: session[:id])
  end

  def is_logged_in?(session)
    session[:user_id].nil? ? false : true
  end
end
