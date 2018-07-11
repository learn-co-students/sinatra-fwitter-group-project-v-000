require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "programmingisfun"
  end

  get '/' do
    erb :index
  end


  helpers do

    def loggin_in?
      !!session[:id]
    end

    def login(username, password)
      user = User.find_by(:username => username)
      if user && user.authenticate(password)
        session[:id] = user.id
        redirect '/users/show'
      else
        redirect '/login'
      end
    end

    def logout!
      session.clear
    end
  end
end
