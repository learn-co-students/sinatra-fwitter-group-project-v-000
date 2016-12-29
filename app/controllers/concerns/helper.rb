module Helper

  def logged_in?
    !!session[:id]
  end

  def current_user
    User.find(session[:id])
  end

end
