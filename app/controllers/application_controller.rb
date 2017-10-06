require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_security"
  end

  get '/' do
    erb :index
  end

helpers do
  def current_user
    current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    # User.find_by(session[:user_id])
    #default is nil if session[:user_id] doesn't exist
  end

  def logged_in?
    # !!session[:user_id]
    !!current_user
  end
end

end
