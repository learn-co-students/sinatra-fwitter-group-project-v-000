require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
      erb :'users/create_user'
  end

  post '/signup' do

    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id

      redirect to '/tweets'
    end

  end

  get '/login' do
      erb :'users/login'
  end

  post '/login' do
      @user = User.find_by(:username => params[:username])
      if @user != nil && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to '/tweets'
      else
          redirect to '/signup'
      end
  end

  get '/tweets' do
    if session[:user_id]
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
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
