module LoginHelpers

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def nil_submission?
      params.any? {|key, value| value == "" }
    end

end
