require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    if !logged_in?
      erb :index
    else
      redirect '/tweets'
    end
  end

  get '/failure' do
    erb :'users/failure'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def login_check
      if !logged_in?
        flash[:message] = "Please log in first."
        redirect '/login'
      end
    end

  end

end
