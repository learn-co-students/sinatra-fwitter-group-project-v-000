require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    @user = User.find_by(id: session[:id])
    if !!@user
      redirect to('/tweets')
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    @user = User.create(params)
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect to('/signup')
    end
  end

  get '/tweets' do
    @user = User.find_by(id: session[:user_id])
    erb :'tweets/tweets'
  end






  helpers do
    def logged_in?
      !!session[:user_id]
    end
    def current_user
      User.find_by(id: session[:user_id])
    end
  end

end
