require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do

    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :signup
    elsif logged_in?
      redirect '/tweets'
    end
  end

  post '/signup' do
    # binding.pry

      # binding.pry
      if params["username"] != "" && params["email"] != "" && params["password"] != ""
        user = User.create(:username => params["username"], :email => params["email"], :password => params["password"])
        session[:user_id] = user.id
        # binding.pry
        redirect '/tweets'
      else redirect '/signup'
      end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
