module UserHelper

  def registered_user?
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:current_user] = @user
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  def new_user
    @user = User.new
    @user.username = params[:username]
    @user.password = params[:password]
    @user.email = params[:email]
    @user
  end

  def already_logged_in?
    redirect '/tweets' if session[:current_user]
  end

  def not_logged_in?
    redirect '/login' unless session[:current_user]
  end
end

