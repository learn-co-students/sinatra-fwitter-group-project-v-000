require './config/environment'

class ApplicationController < Sinatra::Base
  #==================== CONFIGURATION =====================  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end
  #--------------------------------------------------------


  #==================== INDEX =============================
  get '/' do
    erb :'index'
  end
  #--------------------------------------------------------

 
  #==================== HELPERS ===========================
  helpers do
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    def logged_in?
      !!current_user
    end

    def valid_signup?
      !params.any?{|i| i[1].empty?}
    end

    def tweet_exists?(tweet_id)
      Tweet.find_by_id(tweet_id) != nil
    end

  end
  #--------------------------------------------------------

end