require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'MINSWAN'
  end

  get '/' do
    erb :index
  end

  get '/home' do
    if logged_in?
      @user=current_user
      erb :index
    else
      redirect '/'
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find(session[:id])
    end
  end

end

