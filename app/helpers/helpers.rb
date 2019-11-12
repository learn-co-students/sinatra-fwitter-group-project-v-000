class Helpers #controls logic in views

#singleton method or class method; a method added to a class Objectives
#instance of the class Class
 def self.current_user(session_hash)
   @user = User.find(session_hash[:user_id])
 end

#logging in stores the user's ID in the session hash
 def self.is_logged_in?(session_hash)
   !!session_hash[:user_id]
 end
end
