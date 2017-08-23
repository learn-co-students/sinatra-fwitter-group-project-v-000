require 'pry'

module Helpers

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by_id(session[:id])
  end

  def check_login_status
    unless logged_in?
      redirect to '/login'
    end
  end

end
