require './config/environment'
class ApplicationController < Sinatra::Base
  set :session_secret, "my_application_secret"
  enable :sessions

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    if is_logged_in?
      erb :'/tweets/tweets'
    else
      erb :index
    end
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def is_logged_in?
      !!session[:user_id]
    end
  end

end
