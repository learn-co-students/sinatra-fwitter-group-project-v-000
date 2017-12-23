require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

  end
end
