require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions unless test?
    set :session_secret, "fwitter_secret_sessions"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  use Rack::Flash

  get '/' do
    if logged_in?
      redirect '/tweets'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:id]
    end

    def current_user
      User.find session[:id]
    end
  end
end
