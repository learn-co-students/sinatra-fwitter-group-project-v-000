require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      erb :"/tweets/tweets"
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end
  end
end
