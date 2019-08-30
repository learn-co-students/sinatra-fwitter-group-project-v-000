require './config/environment'

class ApplicationController < Sinatra::Base

  #
  configure do
    set :public_folder, 'public'
    # tell Sinatra where to look for views
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "tweetkcret"
  end

  # root route
  get '/' do
    # tell Sinatra what to do
    erb :index # reference to file, not new HTTP request
  end

  # helper methods
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      # if @current_user is assigned, don't evaluate
      @current_user ||= User.find(session[:user_id])
    end

    # if none of params values are blank, returns true
    def valid_params?
      params.none? do |k,v|
        v == ""
      end
    end
  end
  
end
