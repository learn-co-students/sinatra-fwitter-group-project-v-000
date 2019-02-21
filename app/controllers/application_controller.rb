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

  helpers do

    def logged_in?
      !!session[:email]
    end

    def login(username, email, password)
      user = User.find_by(username: username, email: email, password: password)

      if user
        session[:email] = user.email
      else
        redirect '/login'
      end
    end

    def logout
      session.clear
    end

  end
end
