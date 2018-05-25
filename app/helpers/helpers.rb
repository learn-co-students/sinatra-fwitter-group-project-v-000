class Helpers
    def self.current_user(session)
        @user = User.find(session[:user_id])
    end
    
    def self.logged_in?(session)
        @user = User.find_by(id: session[:user_id])
        !(@user == nil)
    end
end