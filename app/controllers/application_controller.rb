require './config/environment'
require "./app/models/user"

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
  
  get '/tweets' do
    erb :'tweets/tweets'
  end
  
  get '/signup' do

    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end
  
  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
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