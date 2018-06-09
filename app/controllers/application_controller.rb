require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions unless test? #test? refers to base method used for environment selection
    set :session_secret, "secret"
  end

  get '/' do
    erb :'application/root'
  end

  helpers do

    def logged_in?
      #the '!!' double bang converts object into a truthy value statement
      !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end

    def twitter_user(tweet)
      user = User.find_by_id(tweet.user_id)
      user.username
    end
  end

end