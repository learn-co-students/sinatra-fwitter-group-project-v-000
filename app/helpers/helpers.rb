class Helpers

  def self.logged_in?(session)
    !!session[:user_id]
  end

  def self.current_user(session)
    User.all.find{|user| user.id == session[:user_id]}
  end
end
