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
end
