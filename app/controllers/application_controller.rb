require './config/environment'
use Rack::MethodOverride
class ApplicationController < Sinatra::Base
  

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
    set :session_secret, "my_secret_password"

  end

  get '/' do
    erb :home
  end

  helpers do

  def logged_in?
    !!session[:user_id]
  end

  def login(email, password)
    user = User.find_by(:email => email)
    if user && user.authenticate(password)
      session[:email] = user.email
    else
      redirect '/login'
    end
  end

  def logout!
    session.clear
    redirect '/login'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
 end

end
