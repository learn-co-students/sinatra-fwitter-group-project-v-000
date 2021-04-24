=begin
PLACED IN APPLICATION_CONTROLLER
class helpers
  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end
end
=end
class Helpers
  def self.current_user(session)
     @user = User.find(session[:user_id])
  end

  def self.is_logged_in?(session)
    session[:user_id] != nil
  end
end
=begin
APPLICATION CONTROLLER
get '/account' do
  if Helpers.is_logged_in?(session)
    @user = Helpers.current_user(session)
    erb :account
  else
    erb :error
  end
end
=end
