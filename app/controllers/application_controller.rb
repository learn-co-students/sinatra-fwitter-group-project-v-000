require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  # Helper Methods
  def current_user
    User.find_by(id: session[:user_id])
    # The 'find_by' method will return nil if nothing is found, 
    # whereas the 'find' method will throw an error instead.
  end

  def logged_in?
    !!current_user
    # Using 'current_user' is more secure than using 'session[:user_id]' 
    # because, again, you will get a nil answer if no such thing exists.
  end

end
