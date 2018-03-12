require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret","password_security"
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect to :"/tweets"
    else
      erb :'/users/create_user'
    end
  end
  get '/login' do
    if logged_in?
      redirect to :"/tweets"
    else
      erb :"/users/login"
    end
  end
  get '/logout' do
    session.clear
    redirect "/login"
  end
  get '/tweets' do

    if !logged_in?
      redirect to "/login"
    else
      # binding.pry
      @user = User.find_by(session[:user_id])
      erb :"/tweets/tweets"
    end
  end

  post '/signup' do
    # binding.pry
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to :'/signup'
    else
      @user = User.create(params)
      @user.save
      session[:user_id] = @user.id
      redirect to :"/tweets"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id if @user && @user.authenticate(params[:password])
    redirect to :"/tweets"
  end
  post '/tweets' do
    
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
