require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    use Rack::Flash
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def login(username, password)
      @user = User.find_by(username: username)
      if @user && @user.authenticate(password)
        session[:email] = @user.email
        redirect "/tweets"
      else
        redirect "/login"
      end
    end

    def current_user
      @current_user ||= User.find_by(:email => session[:email]) if session[:email]
    end

    def logout
      session.clear
    end
  end

end
