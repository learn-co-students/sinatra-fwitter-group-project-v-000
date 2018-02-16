require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret' # Review sessions
  end

  get '/' do
    erb :'/homepage'
  end

  helpers do
    def logged_in?
      !!current_user
    end

    # Analyze below method and previous errors
    # Before without `if session[:id]` error in browser was
    # no 'id'= since User.find() was executing no matter what
    # without a conditional statement.
    # We need the conditional statement there in order to prevent
    # the error.
    # Why use the double pipes?

    def current_user
      # User.find(session[:user_id]) did not work
      # but User.find_by(id: session[:user_id]) works... Why?
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logout
      session.clear
    end
  end
end
