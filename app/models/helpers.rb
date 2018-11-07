class Helpers

def self.current_user(session)
   @user = User.find_by_id(session[:user_id])
   if @user.is_a?(User)
        @user
   end
 end

 def self.is_logged_in?(session)
   !!User.find_by_id(session[:user_id])
 end

 def self.show_logout(session)
   if !!User.find_by_id(session[:user_id])
      "  <form action= '/logout' method='get'>
      		<input type='submit' value='Logout' />
      	</form>"
   elsif !User.find_by_id(session[:user_id])
      nil
   end
 end


 end
