require 'pry'
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
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do

    if params[:username] == "" || params[:email] == "" || params[:password] == ""

      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])

      session[:user_id] = @user.id

      redirect to '/tweets'
    end

  end

  get '/login' do
    if session[:user_id]
      redirect '/tweets'
    else
      erb :'users/login'
    end
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

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect to '/login'
    else
      redirect to '/'
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
