require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    "Welcome to Fwitter"
  end

  get '/signup' do
    if session[:user_id]
      redirect '/tweets'
    else
      "This is the signup page"
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      #need helper method isLoggedIn?
      redirect '/tweets'
    end
  end

  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/login' do
    if session[:user_id]
      redirect '/tweets'
    else
      "This is the login page"
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
