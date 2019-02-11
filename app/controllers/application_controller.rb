require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @tweets = @user.tweets
      erb :'tweets/tweets'
    else
      erb :index
    end
  end

  helpers do

    def current_user
      if session[:user_id]
        @current_user = User.find_by(id: session[:user_id])
      end
    end

    def logged_in?
      if current_user
        true
      else
        false
      end 
    end
  end
end
