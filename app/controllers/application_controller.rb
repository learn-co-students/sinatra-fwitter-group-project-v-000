require './config/environment'
require "rack-flash"

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ecrypTz0r"
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      logged_in? ? User.find_by(id: session[:user_id]) : nil
    end

    def current_user_owns_tweet?(tweet)
      logged_in? ? tweet.user.id == session[:user_id] : false
    end
  end
end
