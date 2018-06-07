class Helpers
  def self.current_user(session)
    @user = User.find(session[:id])
    @user
  end

  def self.logged_in?(session)
    !!session[:id]? true : false
  end
end
