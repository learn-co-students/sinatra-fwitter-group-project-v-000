require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    enable :sessions
    set :session_secret, "my_application_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  helpers do
    def login(username, password)
      user = User.find_by(:username => username )
      if user && user.authenticate(password)
        session[:email] = user.email
        session[:id] = user.id
      else
        redirect '/login'
      end
    end

    def is_logged_in?
      !!session[:email]
    end

    def logout!
      session.clear
    end

    def current_user
      User.find_by(:email => session[:email])
    end
  end

  get '/' do
    erb :index
  end


end
