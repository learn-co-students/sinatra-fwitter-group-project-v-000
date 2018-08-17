class Helpers

  def self.is_logged_in?(arg)
    if arg[:user_id] != nil
      true
    else
      false
    end
  end

  def self.current_user(arg)
    @user = User.find(arg[:user_id])
    @user
  end

end
