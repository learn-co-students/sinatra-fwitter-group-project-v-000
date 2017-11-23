module Helper

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:id]) if session[:id]
  end

end
