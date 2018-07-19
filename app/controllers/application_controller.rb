require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end

  get "/" do
    erb :index
  end

  helpers do 

    def login(username, password)
      user = User.find_by(username: username)

      if user && user.authenticate(password)
        session[:name] = user.username
      else
        redirect "/login"
      end
    end

    def logged_in?
      !!session[:name]
    end

  end

end
