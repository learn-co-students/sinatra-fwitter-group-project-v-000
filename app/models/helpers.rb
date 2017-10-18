class Helpers

  def self.current_user(session)
    @current_user = User.find_by(session[:user_id])
    binding.pry
    @current_user
    binding.pry
  end

  def self.logged_in?(session)
    !current_user(session[:user_id])
  end

end
