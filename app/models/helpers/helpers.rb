class Helpers

    def self.current_user(session)
        @user = User.find(session[:user_id])
        @user
    end

    def self.logged_in?(session)
      !!session[:user_id]
    end

    def self.find_and_auth(params)
        @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
       @user
     end

    def self.empty?(params)
      params.values.collect{|values| values.strip}.include?("")
    end


end
