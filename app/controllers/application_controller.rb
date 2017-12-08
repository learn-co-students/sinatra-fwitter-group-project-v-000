require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    # binding.pry
    if logged_in?
      erb :'/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
# binding.pry
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
# binding.pry
      # User.find_or_create_by(username: params[:username], email: params[:email], password: params[:password])
      user = User.find_or_create_by(username: params[:username], email: params[:email], password: params[:password])
      user.save

      session[:user_id] = user.id
      redirect to '/tweets'
    else
      # binding.pry
      redirect to '/signup'
    end
  end

  get '/tweets' do
    erb :'/tweets/tweets'
  end

  get '/login' do
    erb :'/users/login'
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
