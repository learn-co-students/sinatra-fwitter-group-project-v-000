require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end
  
  get '/' do
    erb :index
  end
  
  helpers do
    def logged_in?
      !session[:id].nil?
    end

    def current_user
      User.find_by id: session[:id]
    end
    
    def current_tweet
        Tweet.find_by params[:tweet_id]
    end
    
    def slug_name
        User.find_by_slug(params[:slug])
    end

  end
  
end