require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "special_fwitter_secret"
  end

  get '/' do
    erb :index
  end

  def login(username, email, password)
    user = User.find_by(username: username)
    if user && user.authenticate(password)
      session[:username] = user.username
      session[:email] = user.email
    else
      redirect '/login'
    end
  end

  def current_user
    @current_user ||= User.find_by(username: session[:username]) if session[:username]
  end

  def is_logged_in?
    !!current_user
  end

  def logout!
    session.clear
  end

end
