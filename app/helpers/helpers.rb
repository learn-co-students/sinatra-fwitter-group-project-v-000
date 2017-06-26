class Helpers

def self.current_user(session)
if session[:user_id]
User.find(session[:user_id])
end

end#eom


def self.logged_in?(session)
!!session[:user_id]
end



end#eoc