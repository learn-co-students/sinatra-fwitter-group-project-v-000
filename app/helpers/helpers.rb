class Helpers

  def current_user
    binding.pry
    self.find_by_id(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

end
