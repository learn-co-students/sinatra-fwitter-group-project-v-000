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
=begin
    def login
      user = User.find_by(username: params[:username])

      if user && user.authenticate(params[:password])
 			    session[:user_id] = user.id
          redirect "/tweets"
      else
        redirect "/login"
      end
    end
=end
    def current_user
      # if @current_user is assigned, don't evaluate
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      #!!session[:user_id]
      !!current_user
    end

    def authorized_to_edit?(tweet)
      current_user == tweet.user
    end

    # find tweet
    # redirect

    def logout!
      session.clear
      redirect "/login"
    end

    # if none of params values are blank, returns true
    def valid_params?
      params.none? do |k,v|
        v == ""
      end
    end
  end

end
