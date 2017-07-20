module LoginUtils

  def current_user
    User.find(session[:user_id])
  end

  def login(params)

    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome, #{user.username}!"
      redirect '/tweets'
    else
      flash[:message] = "Sorry. Incorrect login information."
      redirect '/login'
    end

  end

  def if_logged_in
    if session[:user_id]
      yield
    else
      flash[:message] = "Please log in."
      redirect '/login'
    end
  end

  def logged_in?
    !!session[:user_id]
  end

  def logout
    session.clear
  end

end
