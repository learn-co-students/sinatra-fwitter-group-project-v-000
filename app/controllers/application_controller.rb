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

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def get_user_by_session
      User.find(session[:user_id])
    end

    def login(user)
      session[:user_id] = user.id
    end

    def get_tweet_by_id(id)
      Tweet.find(id)
    end

    def same_user?(tweet)
      get_user_by_session == tweet.user
    end
  end

end
