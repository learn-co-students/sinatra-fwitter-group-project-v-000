require './config/environment'

class ApplicationController < Sinatra::Base

  enable :sessions
  set :session_secret, "my_application_secret"

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'/index'
  end

  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'/users/create_users'
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/tweets"
    end
  end


  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
