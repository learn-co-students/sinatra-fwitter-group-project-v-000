require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to '/tweets/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      # show a message about invalid sign up
      redirect to '/signup'
    end
    @user = User.create(params)
    session[:user_id] = @user.id

    redirect to '/tweets/tweets'
  end

  get '/login' do
    erb :'/users/login'
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
