require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
	set :session_secret, "Ruby For Dayz"
  end

  get '/' do
    @user = current_user
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
    if logged_in?
      redirect '/tweets'
    else 
      erb :'users/login'
    end 
  end 

  post '/login' do
    @user = User.find_by(username: params[:username]).authenticate(params[:password])
    if @user == false 
      redirect '/login'
    else
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end 

  get '/tweets' do
    if logged_in?
      @user = current_user
      erb :index
    else 
      redirect '/login'
    end
  end 

  get '/logout' do
    session.clear
    redirect '/login'
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