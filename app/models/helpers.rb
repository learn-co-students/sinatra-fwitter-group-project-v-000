class Helpers

  def self.logged_in?
  !!current_user
end

def self.current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

end
