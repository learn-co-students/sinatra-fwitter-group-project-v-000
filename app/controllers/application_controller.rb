require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end

  get '/' do 
    erb :index
  end

  get '/signup' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "Error: Please fill in all the fields."
      redirect to '/signup'
    end
  end

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect to '/'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect to '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/tweets'
    else
      flash[:message] = "It looks like you don't have an account yet. Sign up now to get started."
      redirect to '/signup'
    end
  end


  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end