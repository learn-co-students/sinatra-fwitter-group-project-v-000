require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    enable :sessions
    # set :session_secret, "password_security"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  def current_user
    User.find_by(session[:id])
  end

  def logged_in?
    session[:id] != nil
  end

end
