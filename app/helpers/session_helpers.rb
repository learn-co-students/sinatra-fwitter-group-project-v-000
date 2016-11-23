module SessionHelpers
  def current_user
    User.find(session[:id])
  end

  def is_logged_in?
    !!session[:id]
  end
end

