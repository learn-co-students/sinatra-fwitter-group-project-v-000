require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
	set :session_secret, "Ruby For Dayz"
  end

  get '/' do
  	erb :index
  end 

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else 
      erb :'users/create_user'
    end 
  end 

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect '/tweets'
    end 
  end 

  get '/login' do
    erb :'users/login'
  end 

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

end