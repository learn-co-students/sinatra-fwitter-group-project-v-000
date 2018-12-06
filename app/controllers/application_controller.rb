require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'something_secret'
  end

#the homepage should be accessible withouth the tweets or user and is therefore put in the app controller
  get '/' do
    erb :index
  end

#The same goes for the helper methods which will be needed to make sure users are only creating tweets for their own accounts.

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

  end

end