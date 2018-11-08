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

  get '/login' do
    if !logged_in?
      erb :index
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(username: params["username"])

    if user && user.authenticate(params["password"])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
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
