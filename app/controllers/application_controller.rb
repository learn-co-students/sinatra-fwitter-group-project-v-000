require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "fwitter_secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do #loads homepage-- links to a view that leads to login and signup
    erb :index
  end

  helpers do
    def current_user
      @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!session[:user_id]
    end
  end

  get '/logout' do #clears session hash
    if logged_in?
      session.destroy
      redirect "/login"
    else
      redirect '/'
    end
  end

end
