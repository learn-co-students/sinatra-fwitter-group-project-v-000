class ApplicationController < Sinatra::Base

    configure do
     enable :sessions
     set :session_secret, "my_password"
     set :public_folder, 'public'
     set :views, 'app/views'
    end

    get '/' do
    if logged_in?
      get '/tweets'
    else
      erb :index
    end
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
