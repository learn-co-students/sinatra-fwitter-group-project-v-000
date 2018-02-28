require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret_fwitter"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!current_user
    end
    def current_user
      @current_user ||= User.find(session[:user_id]) if !!session[:user_id]
    end
  get '/logout' do
      if logged_in?
        session.clear
        redirect "/login"
      else
        redirect "/"
      end
    end
  end
end
