require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "fW1tT3r"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

helpers do

  def logged_in?
    !!current_user
  end

  def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def logout!
    session.clear
  end

end

  use Rack::Flash

  get '/' do
    erb :"/index"
  end

end
