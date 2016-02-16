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
    # checks if user is logged in, if not then user gets redirected
    if session[:user_id]
      redirect to '/tweets'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
      @user = User.new(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password]) #password authentication
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
  end

  post '/logout' do
  end

  get '/tweets' do
    if session[:user_id]
      @user = User.find_by_id(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end


end